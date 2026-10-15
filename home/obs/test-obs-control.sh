#!/usr/bin/env bash
# Synthetic credential only. Never reads the live OBS profile.
set -euo pipefail
repo=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/obs-control-test.XXXXXXXX")
trap 'rm -rf -- "$tmp"' EXIT
mkdir -p "$tmp/config/obs-studio" "$tmp/bin"
printf 'fixture-not-a-secret\n' > "$tmp/config/obs-studio/websocket-password"
chmod 0600 "$tmp/config/obs-studio/websocket-password"
printf '%s\n' '#!/usr/bin/env bash' \
  '[[ ${OBS_WEBSOCKET_URL:-} == obsws://127.0.0.1:4455/fixture-not-a-secret ]] || exit 41' \
  '[[ $* != *fixture-not-a-secret* ]] || exit 42' \
  '[[ $# == 2 && $1 == replay && $2 == save ]] || exit 43' \
  'printf "mock OBS command accepted\n"' > "$tmp/bin/obs-cmd"
chmod +x "$tmp/bin/obs-cmd"
result=$(XDG_CONFIG_HOME="$tmp/config" PATH="$tmp/bin:$PATH" \
  bash "$repo/home/obs/obs-control.sh" replay save)
[[ $result == 'mock OBS command accepted' ]] || exit 1
printf 'PASS: password reaches obs-cmd in environment, not argv\n'

if XDG_CONFIG_HOME="$tmp/missing" PATH="$tmp/bin:$PATH" \
  bash "$repo/home/obs/obs-control.sh" replay save > "$tmp/missing.out" 2>&1; then
  printf 'FAIL: missing password must fail on use\n' >&2
  exit 1
fi
[[ $(<"$tmp/missing.out") == *'password missing'* ]] || exit 1
printf 'PASS: no credential is needed for installation; control fails clearly\n'
