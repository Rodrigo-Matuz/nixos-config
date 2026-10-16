#!/usr/bin/env bash
# Non-destructive installer contract checks. Does not install or switch NixOS.
set -euo pipefail
repo=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)

help=$(bash "$repo/install.sh" --help)
if [[ $help != *'preview:'* ]]; then
  printf 'FAIL: help must offer a non-destructive preview mode\n' >&2
  exit 1
fi
printf 'PASS: preview mode is advertised\n'

if [[ $(<"$repo/install.sh") != *"DEFAULT_REPO_URL='https://github.com/Rodrigo-Matuz/nixos-config.git'"* ]]; then
  printf 'FAIL: default source must be the NixOS configuration GitHub repository\n' >&2
  exit 1
fi
printf 'PASS: default source is the NixOS configuration repository\n'

# Run the real CLI with a local Git fixture and a mocked VM builder. No host
# install, mount or switch command is allowed in this test.
command -v script >/dev/null || { printf 'SKIP: util-linux script is required\n' >&2; exit 77; }
tmp=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-installer-test.XXXXXXXX")
trap 'rm -rf -- "$tmp"' EXIT
# Copy only tracked paths. Never bring ignored archives or live credentials into
# the fixture, even when someone has placed them alongside the checkout.
mkdir -p "$tmp/fixture"
git -C "$repo" ls-files -z | tar -C "$repo" --null -T - -cf - | tar -C "$tmp/fixture" -xf -
# Simulate malicious top-level code in a cloned script: preview must not source it.
printf '%s\n' 'printf "UNEXPECTED sourced partitions.sh\n" >> "$MOCK_LOG"' >> "$tmp/fixture/install/partitions.sh"
git -C "$tmp/fixture" init -q
git -C "$tmp/fixture" add -A
git -C "$tmp/fixture" -c user.name=Test -c user.email=test@example.invalid commit -m fixture >/dev/null
mkdir -p "$tmp/bin" "$tmp/home"
# shellcheck disable=SC2016 # Variables expand in the generated mock at runtime.
printf '%s\n' '#!/usr/bin/env bash' \
  'printf "nixos-rebuild %s\\n" "$*" >> "$MOCK_LOG"' \
  'if [[ $1 == build-vm ]]; then' \
  '  mkdir -p result/bin' \
  '  printf "#!/usr/bin/env bash\\nexit 0\\n" > result/bin/run-nixos-vm' \
  '  chmod +x result/bin/run-nixos-vm' \
  'fi' > "$tmp/bin/nixos-rebuild"
# shellcheck disable=SC2016 # Variables expand in the generated mock at runtime.
printf '%s\n' '#!/usr/bin/env bash' \
  'printf "UNEXPECTED mountpoint: %s\\n" "$*" >> "$MOCK_LOG"' \
  'exit 99' > "$tmp/bin/mountpoint"
chmod +x "$tmp/bin/nixos-rebuild" "$tmp/bin/mountpoint"
printf -v cmd '%q ' env "HOME=$tmp/home" "XDG_DATA_HOME=$tmp/home/.local/share" \
  "PATH=$tmp/bin:$PATH" "MOCK_LOG=$tmp/commands.log" \
  bash "$repo/install.sh" --mode preview --repo "$tmp/fixture"
if ! printf 'guest\n\n\n\n\n\nYES\n' | script -q -e -c "$cmd" /dev/null > "$tmp/output.log" 2>&1; then
  printf 'FAIL: unprivileged preview did not build a VM\n' >&2
  sed -n '1,30p' "$tmp/output.log" >&2
  exit 1
fi
[[ -x "$tmp/home/.local/share/dotfiles-preview/portable-config/result/bin/run-nixos-vm" ]] || {
  printf 'FAIL: preview VM launcher missing\n' >&2; exit 1;
}
commands=$(<"$tmp/commands.log")
[[ $commands == *'nixos-rebuild build-vm '* && $commands != *'switch '* && $commands != *'UNEXPECTED '* ]] || {
  printf 'FAIL: preview invoked a host-changing command\n' >&2; exit 1;
}
printf 'PASS: preview never sources cloned partition code before VM confirmation\n'

vm_hardware=$(<"$tmp/home/.local/share/dotfiles-preview/portable-config/hardware-configuration.nix")
[[ $vm_hardware == '{ ... }: { }' ]] || {
  printf 'FAIL: preview must not import the host hardware/disks into the VM\n' >&2
  exit 1
}
printf 'PASS: preview uses VM-only hardware settings\n'

vm_user=$(nix --extra-experimental-features 'nix-command flakes' eval --json \
  "$tmp/home/.local/share/dotfiles-preview/portable-config#nixosConfigurations.install.config.virtualisation.vmVariant.services.getty.autologinUser" \
  --no-write-lock-file 2> "$tmp/nix-eval.log")
[[ $vm_user == '"guest"' ]] || {
  printf 'FAIL: VM console must auto-login as selected user (got %s)\n' "$vm_user" >&2
  exit 1
}
printf 'PASS: VM console logs in as selected user\n'

vm_store=$(nix --extra-experimental-features 'nix-command flakes' build \
  "$tmp/home/.local/share/dotfiles-preview/portable-config#nixosConfigurations.install.config.system.build.vm" \
  --no-link --no-write-lock-file --print-out-paths 2> "$tmp/nix-build.log") || {
  printf 'FAIL: actual VM build failed with VM-only hardware\n' >&2
  sed -n '1,50p' "$tmp/nix-build.log" >&2
  exit 1
}
[[ -x "$vm_store/bin/run-nixos-vm" ]] || {
  printf 'FAIL: real VM launcher missing from build output\n' >&2
  exit 1
}
printf 'PASS: Nix built a real VM launcher with VM-only hardware\n'
# A selected Hermes module must evaluate without a private file or user OAuth.
hermes_index=0
for module in "$repo"/home/*/default.nix "$repo"/home/optional/*/default.nix; do
  [[ -f $module ]] || continue
  name=${module%/default.nix}
  name=${name##*/}
  [[ $name == noctalia ]] && continue
  [[ $name =~ ^[a-z0-9-]+$ ]] || continue
  hermes_index=$((hermes_index+1))
  [[ $name != hermes ]] || break
done
[[ $name == hermes ]] || { printf 'FAIL: Hermes module missing\n' >&2; exit 1; }
mkdir -p "$tmp/home-hermes"
printf -v cmd '%q ' env "HOME=$tmp/home-hermes" \
  "XDG_DATA_HOME=$tmp/home-hermes/.local/share" "PATH=$tmp/bin:$PATH" \
  "MOCK_LOG=$tmp/hermes-commands.log" \
  bash "$repo/install.sh" --mode preview --repo "$tmp/fixture"
if ! printf 'guest\n\n\n\n%s\n\nYES\n' "$hermes_index" | script -q -e -c "$cmd" /dev/null > "$tmp/hermes-output.log" 2>&1; then
  printf 'FAIL: preview with Hermes selected needs no secrets\n' >&2
  sed -n '1,35p' "$tmp/hermes-output.log" >&2
  exit 1
fi
hermes_flake="$tmp/home-hermes/.local/share/dotfiles-preview/portable-config"
hermes_env=$(nix --extra-experimental-features 'nix-command flakes' eval --json \
  "$hermes_flake#nixosConfigurations.install.config.home-manager.users.guest.services.hermes-agent.environmentFiles" \
  --no-write-lock-file 2> "$tmp/hermes-eval.log") || {
  printf 'FAIL: selected Hermes module did not evaluate\n' >&2
  sed -n '1,35p' "$tmp/hermes-eval.log" >&2
  exit 1
}
[[ $hermes_env == '[]' ]] || { printf 'FAIL: selected Hermes requires an undeclared env file\n' >&2; exit 1; }
printf 'PASS: selected Hermes evaluates without credentials\n'

# An expected revision mismatch must abort before evaluating or sourcing the clone.
mkdir -p "$tmp/home-mismatch"
printf -v cmd '%q ' env "HOME=$tmp/home-mismatch" \
  "XDG_DATA_HOME=$tmp/home-mismatch/.local/share" "PATH=$tmp/bin:$PATH" \
  bash "$repo/install.sh" --mode preview --repo "$tmp/fixture" \
  --expect-revision 0000000000000000000000000000000000000000
if script -q -e -c "$cmd" /dev/null > "$tmp/mismatch.log" 2>&1; then
  printf 'FAIL: mismatched revision was accepted\n' >&2; exit 1
fi
[[ $(<"$tmp/mismatch.log") == *'does not match --expect-revision'* ]] || {
  printf 'FAIL: revision failure had the wrong cause\n' >&2; exit 1;
}
printf 'PASS: mismatched clone revision is rejected\n'

# Wallpaper Picker depends on Caelestia's wallpaper command. Selecting only
# Wallpaper Picker must add both Caelestia and Hyprland to the generated profile.
wallpaper_index=0
for module in "$repo"/home/*/default.nix "$repo"/home/optional/*/default.nix; do
  [[ -f $module ]] || continue
  name=${module%/default.nix}
  name=${name##*/}
  [[ $name == noctalia ]] && continue
  [[ $name =~ ^[a-z0-9-]+$ ]] || continue
  wallpaper_index=$((wallpaper_index+1))
  [[ $name != wallpaper ]] || break
done
[[ $name == wallpaper ]] || { printf 'FAIL: Wallpaper Picker module missing\n' >&2; exit 1; }
mkdir -p "$tmp/home-wallpaper"
printf -v cmd '%q ' env "HOME=$tmp/home-wallpaper" \
  "XDG_DATA_HOME=$tmp/home-wallpaper/.local/share" "PATH=$tmp/bin:$PATH" \
  "MOCK_LOG=$tmp/wallpaper-commands.log" \
  bash "$repo/install.sh" --mode preview --repo "$tmp/fixture"
if ! printf 'guest\n\n\n\n%s\n\nYES\n' "$wallpaper_index" | script -q -e -c "$cmd" /dev/null > "$tmp/wallpaper-output.log" 2>&1; then
  printf 'FAIL: preview with Wallpaper Picker selected did not build\n' >&2
  sed -n '1,35p' "$tmp/wallpaper-output.log" >&2
  exit 1
fi
wallpaper_selection="$tmp/home-wallpaper/.local/share/dotfiles-preview/portable-config/install/selection.nix"
selection=$(<"$wallpaper_selection")
[[ $selection == *'"wallpaper"'* && $selection == *'"caelestia"'* && $selection == *'"hyprland"'* ]] || {
  printf 'FAIL: Wallpaper Picker did not add Caelestia and Hyprland\n' >&2; exit 1;
}
printf 'PASS: Wallpaper Picker adds Caelestia and Hyprland\n'
