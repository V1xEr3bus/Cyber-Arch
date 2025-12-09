#!/bin/bash
# ╔════════════════════════════════════════════════════════╗
# ║ toggle_wallpaper_mode.sh                               ║
# ║ Toggles wallpaper mode between 'normal' and 'nsfw'     ║
# ║ Updates mode file and sends a transient notification   ║
# ╚════════════════════════════════════════════════════════╝
set -euo pipefail

MODE_FILE="${HOME}/.config/waypaper/mode"
mkdir -p "$(dirname "$MODE_FILE")"
[[ -f "$MODE_FILE" ]] || echo "normal" > "$MODE_FILE"

current="$(<"$MODE_FILE")"

notify() {
  notify-send \
    -a "Wallpaper Mode" \
    -u low \
    --transient \
    -h string:x-canonical-private-synchronous:wallpaper-mode \
    "$1"
}

if [[ "$current" == "normal" ]]; then
  echo "nsfw" > "$MODE_FILE"
  notify "Wallpaper mode: NSFW 🫣"
else
  echo "normal" > "$MODE_FILE"
  notify "Wallpaper mode: Normal ✅"
fi
