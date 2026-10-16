#!/usr/bin/env bash
# Root-free ISO control-flow test: all privileged commands are mocked and
# every generated path lives under TMPDIR. Never performs a real install.
set -euo pipefail
repo=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
command -v script >/dev/null || { printf 'SKIP: util-linux script is required\n' >&2; exit 77; }
[[ -d /sys/firmware/efi ]] || { printf 'SKIP: UEFI runtime unavailable\n' >&2; exit 77; }
tmp=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-iso-test.XXXXXXXX")
trap 'rm -rf -- "$tmp"' EXIT
mkdir -p "$tmp/fixture" "$tmp/bin" "$tmp/root/boot"
# No ignored backup, local auth store, or untracked files enter the test clone.
git -C "$repo" ls-files -z | tar -C "$repo" --null -T - -cf - | tar -C "$tmp/fixture" -xf -
git -C "$tmp/fixture" init -q
git -C "$tmp/fixture" add -A
git -C "$tmp/fixture" -c user.name=Test -c user.email=test@example.invalid commit -m fixture >/dev/null
printf '%s\n' '#!/usr/bin/env bash' \
  'if [[ $1 == -u ]]; then printf "0\n"; else exec /run/current-system/sw/bin/id "$@"; fi' > "$tmp/bin/id"
printf '%s\n' '#!/usr/bin/env bash' 'exit 0' > "$tmp/bin/mountpoint"
printf '%s\n' '#!/usr/bin/env bash' \
  'while (($#)); do case $1 in --dir) dir=$2; shift 2 ;; *) shift ;; esac; done' \
  'printf "{ ... }: { }\n" > "$dir/hardware-configuration.nix"' > "$tmp/bin/nixos-generate-config"
for name in nixos-rebuild nixos-install nixos-enter; do
  printf '%s\n' '#!/usr/bin/env bash' \
    'printf "%s %s\n" "${0##*/}" "$*" >> "$MOCK_LOG"' > "$tmp/bin/$name"
done
chmod +x "$tmp/bin/"*
# Mirror install.sh's module discovery order; select Git, no secrets.
git_index=0
for module in "$repo"/home/*/default.nix "$repo"/home/optional/*/default.nix; do
  [[ -f $module ]] || continue
  name=${module%/default.nix}; name=${name##*/}
  [[ $name == noctalia ]] && continue
  [[ $name =~ ^[a-z0-9-]+$ ]] || continue
  git_index=$((git_index+1))
  [[ $name != git ]] || break
done
[[ $name == git ]] || { printf 'FAIL: Git module missing\n' >&2; exit 1; }
printf -v cmd '%q ' env "PATH=$tmp/bin:$PATH" "MOCK_LOG=$tmp/commands.log" \
  bash "$repo/install.sh" --mode iso --root "$tmp/root" --repo "$tmp/fixture"
# Trust YES precedes source/eval; second YES permits the mocked install.
if ! printf 'YES\nguest\n\n\n\nyes\n%s\n\nJane Doe\njane@example.org\n\nYES\n' "$git_index" | \
  script -q -e -c "$cmd" /dev/null > "$tmp/output.log" 2>&1; then
  printf 'FAIL: mocked ISO installation failed\n' >&2
  sed -n '1,45p' "$tmp/output.log" >&2
  exit 1
fi
selection="$tmp/root/etc/nixos/portable-config/install/selection.nix"
[[ -s $selection ]] || { printf 'FAIL: selection missing\n' >&2; exit 1; }
flake="$tmp/root/etc/nixos/portable-config"
login=$(nix --extra-experimental-features 'nix-command flakes' eval --json \
  "$flake#nixosConfigurations.install.config.services.getty.autologinUser" \
  --no-write-lock-file 2> "$tmp/eval.log") || {
  printf 'FAIL: selected profile did not evaluate\n' >&2
  sed -n '1,45p' "$tmp/eval.log" >&2
  exit 1
}
[[ $login == '"guest"' ]] || { printf 'FAIL: console auto-login was not selected\n' >&2; exit 1; }
git_user=$(nix --extra-experimental-features 'nix-command flakes' eval --json \
  "$flake#nixosConfigurations.install.config.home-manager.users.guest.programs.git.settings.user" \
  --no-write-lock-file 2> "$tmp/git-eval.log") || {
  printf 'FAIL: portable Git identity did not evaluate\n' >&2
  sed -n '1,45p' "$tmp/git-eval.log" >&2
  exit 1
}
[[ $git_user == *'"name":"Jane Doe"'* && $git_user == *'"email":"jane@example.org"'* ]] || {
  printf 'FAIL: generated Git identity was not the selected user\n' >&2; exit 1;
}
commands=$(<"$tmp/commands.log")
[[ $commands == *'nixos-rebuild dry-build '* && $commands == *'nixos-install --root '* && \
   $commands == *'--no-root-passwd'* && $commands == *'passwd root'* && \
   $commands == *'passwd guest'* && $commands != *'nixos-rebuild switch'* ]] || {
  printf 'FAIL: mocked installer command sequence is wrong\n' >&2; exit 1;
}
printf 'PASS: no-secret ISO path asks for auto-login and Git identity, prompts for passwords\n'
