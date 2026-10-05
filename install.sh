#!/usr/bin/env bash
# Bootstrap a separate NixOS VM preview, install a portable profile from a
# mounted live ISO, or apply it to an already-installed NixOS system.
# Does NOT partition disks or reuse this workstation's UUIDs.
set -Eeuo pipefail

# Planned public dotfiles repo. It does not exist publicly yet; use --repo to
# test with a checkout until it is published. The website URL serving this
# bootstrap script does not identify the repository on its own.
DEFAULT_REPO_URL='https://github.com/Rodrigo-Matuz/dotfiles.git'
repo_url=${NIXOS_CONFIG_REPO:-$DEFAULT_REPO_URL}
ref=''
mode=''
root='/mnt'
stage=''
target=''

usage() {
  printf '%s\n' \
    'Usage: bash install.sh [--mode preview|iso|installed] [--repo GIT_URL] [--ref BRANCH_OR_TAG] [--root /mnt]' \
    '' \
    'Clones DEFAULT_REPO_URL automatically; --repo overrides it.' \
    'preview:   build an isolated NixOS VM; no root privileges or host activation.' \
    'iso:       /mnt and /mnt/boot must already be mounted; runs nixos-install.' \
    'installed: preserves /etc/nixos; requires an existing systemd-boot installation.' \
    'All modes require x86_64, NixOS, and an interactive terminal.' \
    'No disks are formatted. No existing /etc/nixos files are overwritten.'
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

# Pick discovered modules. Adding home/<name>/default.nix or
# system/<name>/default.nix makes a module appear here automatically.
# Modules needing additional external flake imports also need wiring in
# install/portable.nix; see install/README.md.
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
    --mode|--repo|--ref|--root)
      (($# >= 2)) || fail "Missing value for $1"
      case $1 in
        --mode) mode=$2 ;;
        --repo) repo_url=$2 ;;
        --ref) ref=$2 ;;
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
clone=(git clone --depth 1)
[[ -z $ref ]] || clone+=(--branch "$ref")
clone+=(-- "$repo_url" "$stage/repo")
printf 'Fetching dotfiles from %s...\n' "$repo_url"
"${clone[@]}" || fail "Could not clone $repo_url (the dotfiles repo may not be public yet; use --repo URL for a test checkout)"
repo="$stage/repo"
[[ -s $repo/flake.nix && -s $repo/flake.lock && -s $repo/install/portable.nix && -s $repo/install/selection.nix ]] || fail 'Repository is missing the installer flake files'

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

shopt -s nullglob
home_choices=()
for module in "$repo"/home/*/default.nix; do
  name=${module%/default.nix}
  name=${name##*/}
  # These two modules reference undeclared flake inputs in the current repo.
  [[ $name == noctalia || $name == snappy-switcher ]] && continue
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
if has_choice nvim && has_choice nvchad; then
  fail 'nvim and nvchad both manage Neovim; choose one'
fi
if has_choice caelestia && has_choice wallpaper; then
  fail 'caelestia and wallpaper both manage wallpapers; choose one'
fi
if has_choice caelestia && ! has_choice hyprland; then
  selected_home+=(hyprland)
  printf 'Added Hyprland: Caelestia needs a graphical session.\n'
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
  printf '];\n}\n'
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
else
  nixos-rebuild switch --flake "$target#install" --no-write-lock-file
  printf '\nSet or confirm a password for %s:\n' "$username"
  passwd "$username"
  printf 'Configuration activated: %s\n' "$target"
fi
