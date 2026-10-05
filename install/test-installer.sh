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

if [[ $(<"$repo/install.sh") != *"DEFAULT_REPO_URL='https://github.com/Rodrigo-Matuz/dotfiles.git'"* ]]; then
  printf 'FAIL: default source must be the planned dotfiles GitHub repository\n' >&2
  exit 1
fi
printf 'PASS: default source is the planned dotfiles repository\n'

# Run the real CLI with a local Git fixture and a mocked VM builder. No host
# install, mount or switch command is allowed in this test.
command -v script >/dev/null || { printf 'SKIP: util-linux script is required\n' >&2; exit 77; }
tmp=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-installer-test.XXXXXXXX")
trap 'rm -rf -- "$tmp"' EXIT
cp -a "$repo" "$tmp/fixture"
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
printf 'PASS: unprivileged VM preview keeps host untouched\n'

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
