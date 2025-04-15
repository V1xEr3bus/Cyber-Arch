#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║ toggle_window_state.sh                                           ║
# ║ Toggles between floating, fullscreen, and tiled window states    ║
# ║ Uses `hyprctl` to check and control active window behavior       ║
# ╚══════════════════════════════════════════════════════════════════╝

WINDOW_INFO=$(hyprctl activewindow -j)
IS_FLOATING=$(echo "$WINDOW_INFO" | jq -r '.floating')
IS_FULLSCREEN=$(echo "$WINDOW_INFO" | jq -r '.fullscreen')

if [ "$IS_FLOATING" == "true" ]; then
    hyprctl dispatch togglefloating
    hyprctl dispatch fullscreen
elif [ "$IS_FULLSCREEN" != "0" ]; then
    hyprctl dispatch fullscreen
else
    hyprctl dispatch togglefloating
fi
