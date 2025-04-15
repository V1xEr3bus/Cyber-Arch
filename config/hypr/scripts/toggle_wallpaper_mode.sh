#!/bin/bash
# ╔════════════════════════════════════════════════════════╗
# ║ toggle_wallpaper_mode.sh                               ║
# ║ Toggles wallpaper mode between 'normal' and 'nsfw'     ║
# ║ Updates mode file and sends desktop notification       ║
# ╚════════════════════════════════════════════════════════╝

MODE_FILE="$HOME/.config/waypaper/mode"
current=$(cat "$MODE_FILE")

if [[ "$current" == "normal" ]]; then
    echo "nsfw" > "$MODE_FILE"
    notify-send "Wallpaper mode: NSFW 🫣"
else
    echo "normal" > "$MODE_FILE"
    notify-send "Wallpaper mode: Normal ✅"
fi
