#!/bin/bash
# ╔═════════════════════════════════════════════════════════════════════╗
# ║ rotate_wallpapers.sh                                                ║
# ║ Automatically rotates wallpapers based on mode (normal / nsfw)      ║
# ║ by delegating to change_wallpaper.sh every $INTERVAL seconds        ║
# ╚═════════════════════════════════════════════════════════════════════╝

INTERVAL=3600
SCRIPT_DIR="$(dirname "$0")"
swww init &> /dev/null

while true; do
  "$SCRIPT_DIR/change_wallpaper.sh"
  sleep $INTERVAL
done
