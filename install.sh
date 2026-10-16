#!/usr/bin/env bash
# Bootstrap a separate NixOS VM preview, install a portable profile from a
# mounted live ISO, or apply it to an already-installed NixOS system.
# Does NOT repartition/format disks or reuse this workstation's UUIDs.
set -Eeuo pipefail

# Public dotfiles repository used by the short installer URL. Use --repo for a
# private/local checkout or a different source.
DEFAULT_REPO_URL='https://github.com/Rodrigo-Matuz/nixos-config.git'
repo_url=${NIXOS_CONFIG_REPO:-$DEFAULT_REPO_URL}
ref=''
expected_revision=''
mode=''
root='/mnt'
stage=''
target=''

usage() {
  printf '%s\n' \
    'Usage: bash install.sh [--mode preview|iso|installed] [--repo GIT_URL] [--ref BRANCH_OR_TAG] [--expect-revision FULL_SHA] [--root /mnt]' \
    '' \
    'Clones DEFAULT_REPO_URL automatically; --repo overrides it.' \
    'preview:   build an isolated NixOS VM; no root privileges or host activation.' \
    'iso:       /mnt and /mnt/boot must already be mounted; runs nixos-install.' \
    'installed: preserves /etc/nixos; requires an existing systemd-boot installation.' \
    'Use --expect-revision to reject a changed/mismatched clone before evaluating it.' \
    'All modes require x86_64, NixOS, and an interactive terminal.' \
    'Optional data-volume mounting uses existing filesystems; no formatting or repartitioning.' \
    'No existing /etc/nixos files are overwritten.'
}

fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
require() { command -v "$1" >/dev/null 2>&1 || fail "Missing command: $1"; }

cleanup() {
  if [[ -n $stage && -d $stage ]]; then
    rm -rf -- "$stage"
  fi
}
trap cleanup EXIT

ask() {
  local label=$1 default=${2-} answer
  printf '%s [%s]: ' "$label" "$default" >&2
  IFS= read -r answer </dev/tty || fail 'Could not read from the terminal'
  REPLY=${answer:-$default}
}

confirm() {
  local answer
  printf '%s Type YES to continue: ' "$1" >&2
  IFS= read -r answer </dev/tty || fail 'Could not read from the terminal'
  [[ $answer == YES ]] || fail 'Cancelled'
}

has_choice() {
  local needle=$1 choice
  for choice in "${selected_home[@]:-}"; do
    [[ $choice == "$needle" ]] && return 0
  done
  return 1
}

# Pick discovered modules. Adding home/<name>/default.nix makes a module part
# of the workstation profile automatically. Optional modules live under
# home/optional/<name>/default.nix and are offered by the installer without
# being imported into the workstation.
pick_modules() {
  local label=$1 input count value i
  local -n choices=$2 selected=$3
  selected=()
  printf '\n%s (optional):\n' "$label"
  for ((i=0; i<${#choices[@]}; i++)); do
    printf '  %2d) %s\n' "$((i+1))" "${choices[i]}"
  done
  printf 'Numbers separated by spaces/commas, or Enter for none: ' >&2
  IFS= read -r input </dev/tty || fail 'Could not read module selection'
  input=${input//,/ }
  for value in $input; do
    [[ $value =~ ^[0-9]+$ ]] || fail "Invalid selection: $value"
    count=$((10#$value))
    ((count >= 1 && count <= ${#choices[@]})) || fail "Out of range: $value"
    value=${choices[count-1]}
    local found=false item
    for item in "${selected[@]:-}"; do
      [[ $item == "$value" ]] && found=true
    done
    [[ $found == true ]] || selected+=("$value")
  done
}

while (($#)); do
  case $1 in
    --mode|--repo|--ref|--expect-revision|--root)
      (($# >= 2)) || fail "Missing value for $1"
      case $1 in
        --mode) mode=$2 ;;
        --repo) repo_url=$2 ;;
        --ref) ref=$2 ;;
        --expect-revision) expected_revision=$2 ;;
        --root) root=$2 ;;
      esac
      shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; fail "Unknown option: $1" ;;
  esac
done

[[ -r /dev/tty && -w /dev/tty ]] || fail 'An interactive terminal is required'
[[ $(uname -m) == x86_64 ]] || fail 'Only x86_64-linux is supported by this flake'
[[ $repo_url != -* ]] || fail 'Git URL must not start with a dash'
[[ -z $expected_revision || $expected_revision =~ ^[0-9a-fA-F]{40}$ ]] || fail '--expect-revision must be a full 40-character Git commit SHA'
require nix
if ! command -v git >/dev/null 2>&1; then
  printf 'Git is missing; fetching a temporary Git from nixpkgs...\n'
  git_store=$(nix --extra-experimental-features 'nix-command flakes' build --no-link --print-out-paths nixpkgs#git)
  [[ -x $git_store/bin/git ]] || fail 'Could not obtain Git from nixpkgs'
  export PATH="$git_store/bin:$PATH"
fi
require git
require nixos-rebuild
require nixos-version

if [[ -z $mode ]]; then
  ask 'Mode (preview, iso or installed)' 'preview'
  mode=$REPLY
fi
case $mode in
  preview)
    [[ $(id -u) != 0 ]] || fail 'Run preview without sudo; the VM needs a user-owned checkout'
    [[ $root == /mnt ]] || fail '--root is only supported in iso mode'
    parent="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles-preview"
    ;;
  iso)
    [[ $(id -u) == 0 ]] || fail 'Run ISO installation as root (sudo bash install.sh --mode iso)'
    [[ -d /sys/firmware/efi ]] || fail 'Boot the installer in UEFI mode'
    require mountpoint
    require nixos-install
    require nixos-generate-config
    require nixos-enter
    [[ $root == /* && $root != / ]] || fail '--root must be an absolute mount directory'
    mountpoint -q "$root" || fail "Mount the target root filesystem on $root first"
    mountpoint -q "$root/boot" || fail "Mount the EFI system partition on $root/boot first"
    parent="$root/etc/nixos"
    ;;
  installed)
    [[ $(id -u) == 0 ]] || fail 'Run installed mode as root (sudo bash install.sh --mode installed)'
    [[ -d /sys/firmware/efi ]] || fail 'Installed mode requires UEFI'
    require mountpoint
    [[ $root == /mnt ]] || fail '--root is only supported in iso mode'
    require bootctl
    bootctl is-installed >/dev/null 2>&1 || fail 'Installed mode requires an existing systemd-boot setup; do not change bootloaders automatically'
    mountpoint -q /boot || fail 'Mount the existing EFI system partition at /boot first'
    [[ -s /etc/nixos/hardware-configuration.nix ]] || fail 'Missing existing /etc/nixos/hardware-configuration.nix'
    parent='/etc/nixos'
    ;;
  *) fail 'Choose --mode preview, iso or installed' ;;
esac

# nixos-install's ISO and existing systems do not necessarily enable flakes.
export NIX_CONFIG="${NIX_CONFIG:+${NIX_CONFIG}$'\n'}experimental-features = nix-command flakes"
mkdir -p -- "$parent"
target="$parent/portable-config"
[[ ! -e $target && ! -L $target ]] || fail "Destination already exists: $target (move it aside manually before retrying)"
stage=$(mktemp -d "$parent/.nixos-install-stage.XXXXXXXX")
clone=(git clone --depth 1 --no-local)
[[ -z $ref ]] || clone+=(--branch "$ref")
clone+=(-- "$repo_url" "$stage/repo")
printf 'Fetching dotfiles from %s...\n' "$repo_url"
"${clone[@]}" || fail "Could not clone $repo_url (the dotfiles repo may not be public yet; use --repo URL for a test checkout)"
repo="$stage/repo"
revision=$(git -C "$repo" rev-parse --verify HEAD) || fail 'Could not identify cloned revision'
[[ -z $expected_revision || ${revision,,} == ${expected_revision,,} ]] || fail "Clone revision $revision does not match --expect-revision $expected_revision"
printf 'Source: %s\nRevision: %s\n' "$repo_url" "$revision"
[[ -s $repo/flake.nix && -s $repo/flake.lock && -s $repo/install/portable.nix && -s $repo/install/selection.nix && -s $repo/install/partitions.nix && -s $repo/install/partitions.sh ]] || fail 'Repository is missing the installer flake files'

# Cloned Nix and shell files are executable code. Confirm trust BEFORE sourcing
# partitions.sh or evaluating the clone as root; activation has a separate prompt.
if [[ $mode != preview ]]; then
  confirm "Trust $repo_url at $revision? The installer will run its shell/Nix code as root."
fi

if [[ $mode == iso ]]; then
  nixos-generate-config --root "$root" --dir "$repo"
elif [[ $mode == preview ]]; then
  # build-vm supplies its own virtual root device; never import host UUIDs.
  printf '{ ... }: { }\n' > "$repo/hardware-configuration.nix"
else
  install -m 0644 /etc/nixos/hardware-configuration.nix "$repo/hardware-configuration.nix"
fi
[[ -s $repo/hardware-configuration.nix ]] || fail 'Hardware generation/copy failed'

case $mode in
  preview) default_user=$(id -un) ;;
  installed) default_user=${SUDO_USER:-} ;;
  *) default_user='' ;;
esac
ask 'Username for the new account (required)' "$default_user"
username=$REPLY
[[ $username =~ ^[a-z_][a-z0-9_-]*$ ]] || fail 'Username must contain only lowercase letters, digits, underscore, or hyphen'
[[ $username != root ]] || fail 'Choose a normal username, not root'
if [[ $mode == installed ]]; then
  uid=$(id -u "$username" 2>/dev/null) || fail 'Installed mode requires an existing login account; create it before switching'
  ((uid >= 1000)) || fail 'Installed mode requires an existing non-system user account'
fi
ask 'Hostname' 'nixos'
hostname=$REPLY
[[ $hostname =~ ^[a-z][a-z0-9-]*$ && ${#hostname} -le 63 ]] || fail 'Invalid hostname'
ask 'IANA time zone' 'Etc/UTC'
timezone=$REPLY
[[ $timezone =~ ^[A-Za-z0-9_+./-]+$ && $timezone != *..* ]] || fail 'Invalid time zone'
if [[ $mode == iso || $mode == preview ]]; then
  version=$(nixos-version 2>/dev/null || true)
  [[ $version =~ ^([0-9]{2}\.[0-9]{2}) ]] || fail 'Could not determine NixOS state version'
  ask 'NixOS state version (VM-only in preview mode)' "${BASH_REMATCH[1]}"
else
  ask 'Original system.stateVersion from your existing config (required)' ''
fi
state_version=$REPLY
[[ $state_version =~ ^[0-9]{2}\.[0-9]{2}$ ]] || fail 'Invalid state version'

# Preview always logs in inside its VM; real installations make this opt-in.
auto_login=false
if [[ $mode != preview ]]; then
  printf 'Auto-login gives anyone at the physical console access to this user session.\n'
  ask "Auto-login $username on the first console? (yes/no)" 'no'
  case ${REPLY,,} in
    yes|y) auto_login=true ;;
    no|n) ;;
    *) fail 'Answer yes or no for console auto-login' ;;
  esac
fi

shopt -s nullglob
home_choices=()
for module in "$repo"/home/*/default.nix "$repo"/home/optional/*/default.nix; do
  [[ -f $module ]] || continue
  name=${module%/default.nix}
  name=${name##*/}
  # Noctalia still has no declared flake input in this repository.
  [[ $name == noctalia ]] && continue
  [[ $name =~ ^[a-z0-9-]+$ ]] || continue
  home_choices+=("$name")
done
system_choices=(steam)
for module in "$repo"/system/*/default.nix; do
  name=${module%/default.nix}
  name=${name##*/}
  [[ $name =~ ^[a-z0-9-]+$ ]] && system_choices+=("$name")
done
selected_home=()
selected_system=()
pick_modules 'Home Manager modules' home_choices selected_home
pick_modules 'System modules' system_choices selected_system

# Store only validated, non-secret Git identity strings in this local profile.
# Avoid silently attributing another person's commits to the repo owner.
git_name_expr=null
git_email_expr=null
if has_choice git; then
  ask 'Git author name (optional; Enter to configure later)' ''
  git_name=$REPLY
  ask 'Git author email (optional; Enter to configure later)' ''
  git_email=$REPLY
  if [[ -n $git_name || -n $git_email ]]; then
    [[ -n $git_name && -n $git_email ]] || fail 'Enter both Git author name and email, or leave both blank'
    [[ $git_name =~ ^[[:alnum:]\ ._-]+$ ]] || fail 'Git name may contain letters, digits, spaces, dot, underscore, and hyphen only'
    [[ $git_email =~ ^[A-Za-z0-9._%+@-]+$ && $git_email == *@* ]] || fail 'Invalid Git email'
    git_name_expr="\"$git_name\""
    git_email_expr="\"$git_email\""
  fi
fi
if has_choice nvim && has_choice nvchad; then
  fail 'nvim and nvchad both manage Neovim; choose one'
fi
if has_choice wallpaper && ! has_choice caelestia; then
  selected_home+=(caelestia)
  printf 'Added Caelestia: Wallpaper Picker uses the Caelestia wallpaper command.\n'
fi
if has_choice caelestia && has_choice noctalia; then
  fail 'caelestia and noctalia are both desktop shells; choose one'
fi
if has_choice caelestia && ! has_choice hyprland; then
  selected_home+=(hyprland)
  printf 'Added Hyprland: Caelestia needs a graphical session.\n'
fi
# Do not source cloned shell code during preview before its build confirmation.
partition_owner_uid=null
if [[ $mode != preview ]]; then
  source "$repo/install/partitions.sh"
  configure_partitions "$mode" "$root" "$repo" "$username"
fi
printf '\nSelected home modules: %s\n' "${selected_home[*]:-(none)}"
printf 'Selected system modules: %s\n' "${selected_system[*]:-(none)}"
printf '%s\n' 'Note: Hyprland, Caelestia, OBS, Steam, Git, and Hermes modules contain personal hardware/settings assumptions; review them before proceeding.'

{
  printf '{\n  username = "%s";\n  hostname = "%s";\n  timeZone = "%s";\n  stateVersion = "%s";\n' "$username" "$hostname" "$timezone" "$state_version"
  printf '  homeModules = [ '
  if ((${#selected_home[@]})); then printf '"%s" ' "${selected_home[@]}"; fi
  printf '];\n  systemModules = [ '
  if ((${#selected_system[@]})); then printf '"%s" ' "${selected_system[@]}"; fi
  printf '];\n  autoLogin = %s;\n  gitAuthorName = %s;\n  gitAuthorEmail = %s;\n  partitionOwnerUid = %s;\n}\n' \
    "$auto_login" "$git_name_expr" "$git_email_expr" "$partition_owner_uid"
} > "$repo/install/selection.nix"

if [[ $mode == preview ]]; then
  confirm 'Build a separate NixOS VM without changing the running system?'
  mv -- "$repo" "$target"
  (cd "$target" && nixos-rebuild build-vm --flake .#install --no-write-lock-file)
  vm_launchers=("$target"/result/bin/run-*-vm)
  ((${#vm_launchers[@]} == 1)) || fail "VM build did not produce a launcher under $target/result/bin"
  printf 'VM ready. Start it from the preview directory:\n  cd %q && ./result/bin/%q\n' "$target" "${vm_launchers[0]##*/}"
  exit 0
fi

printf '\nChecking the selected profile without activating it...\n'
nixos-rebuild dry-build --flake "$repo#install" --no-write-lock-file

if [[ $mode == iso ]]; then
  confirm "Install NixOS to the already-mounted filesystems under $root?"
else
  confirm 'Switch this installed NixOS system to the selected profile?'
fi
# Keep the original /etc/nixos intact. Only the new subdirectory is moved.
mv -- "$repo" "$target"
chmod 755 "$target"
if [[ $mode == iso ]]; then
  # nixos-install skips the root password when launched from `curl | bash`
  # because stdin is not a TTY. Prompt explicitly through nixos-enter instead.
  nixos-install --root "$root" --flake "$target#install" --no-channel-copy --no-root-passwd
  printf '\nSet a root password:\n'
  if ! nixos-enter --root "$root" --command 'passwd root'; then
    fail "NixOS installed, but the root password was not set. Retry: nixos-enter --root '$root' --command 'passwd root'"
  fi
  printf '\nSet a password for %s:\n' "$username"
  if ! nixos-enter --root "$root" --command "passwd $username"; then
    fail "NixOS installed, but the user's password was not set. Retry: nixos-enter --root '$root' --command 'passwd $username'"
  fi
  printf 'Installation complete. Configuration: %s; reboot when ready.\n' "$target"
  if has_choice hermes; then
    printf 'After first login, run `hermes model` to sign in to your provider. No secrets were required during installation.\n'
  fi
else
  nixos-rebuild switch --flake "$target#install" --no-write-lock-file
  printf 'Configuration activated: %s. Confirm you can log in with the existing %s account before rebooting.\n' "$target" "$username"
  if has_choice hermes; then
    printf 'Run `hermes model` as %s to sign in to your provider if needed.\n' "$username"
  fi
fi
