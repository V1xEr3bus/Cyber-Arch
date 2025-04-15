#!/bin/bash

HIST_FILE="$HOME/.local/share/rofi-clipboard/history.txt"
PIN_FILE="$HOME/.local/share/rofi-clipboard/pins.txt"
mkdir -p "$(dirname "$HIST_FILE")"
touch "$HIST_FILE" "$PIN_FILE"

last=""

while true; do
    current=$(wl-paste --no-newline)
    if [[ -n "$current" && "$current" != "$last" ]]; then
        grep -Fxq "$current" "$HIST_FILE" || echo "$current" >> "$HIST_FILE"
        last="$current"
    fi
    sleep 1
done
