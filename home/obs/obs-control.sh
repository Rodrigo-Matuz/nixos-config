#!/usr/bin/env bash
set -euo pipefail

password_file="${XDG_CONFIG_HOME:-$HOME/.config}/obs-studio/websocket-password"
if [[ ! -r $password_file ]]; then
  printf 'OBS WebSocket password missing: %s\n' "$password_file" >&2
  exit 1
fi
password=$(<"$password_file")
if [[ -z $password ]]; then
  printf 'OBS WebSocket password is empty: %s\n' "$password_file" >&2
  exit 1
fi
# obs-cmd accepts the URL via its environment; keep the password out of argv.
export OBS_WEBSOCKET_URL="obsws://127.0.0.1:4455/$password"
unset password
exec obs-cmd "$@"
