#!/usr/bin/env bash
set -euo pipefail

password="$(cat "$HOME/.config/obs-studio/websocket-password")"

exec obs-cmd \
  --websocket "obsws://127.0.0.1:4455/$password" \
  "$@"
