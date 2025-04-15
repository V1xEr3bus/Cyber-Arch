#!/bin/bash

# ╔════════════════════════════════════════════════════╗
# ║            Rofi Clipboard Manager for Arch Linux   ║
# ║  Supports history view, pinning, and clearing      ║
# ╚════════════════════════════════════════════════════╝

HIST_FILE="$HOME/.local/share/rofi-clipboard/history.txt"
PIN_FILE="$HOME/.local/share/rofi-clipboard/pins.txt"
mkdir -p "$(dirname "$HIST_FILE")"
touch "$HIST_FILE" "$PIN_FILE"

read -r -d '' rofi_theme <<EOF
* {
  margin: 0;
  padding: 0;
  spacing: 0;
  font: "JetBrainsMono Nerd Font 16";
}
window {
  location: center;
  width: 25%;
  height: 50%;
  border-radius: 15px;
  background-color: #080808BF;
  y-offset: 15%;
}
listview {
  dynamic: true;
  word-wrap: true;
  lines: 15;
  columns: 1;
  cycle: false;
  fixed-height: false;
  fixed-columns: true;
  spacing: 10;
  padding: 5px;
  layout: vertical;
  uniform-height: false;
}
element {
  padding: 8px;
  border-radius: 10px;
}
element selected {
  background-color: #00F0FF33;
}
EOF

# Merge pins and history (pin first, latest history first)
mapfile -t pins < "$PIN_FILE"
mapfile -t history < "$HIST_FILE"
history=("$(tac "$HIST_FILE")")

combined=("📌 Pin new entry" "🧲 Unpin entry" "🧹 Clear history" "────────────")
combined+=("${pins[@]}")
[[ ${#pins[@]} -gt 0 ]] && combined+=("────────────")
combined+=("${history[@]}")

selection=$(printf '%s\n' "${combined[@]}" | rofi -dmenu -p " Clipboard" -theme-str "$rofi_theme")
[[ -z "$selection" ]] && exit 0

case "$selection" in
  "📌 Pin new entry")
    new_clip=$(wl-paste)
    grep -Fxq "$new_clip" "$PIN_FILE" || echo "$new_clip" >> "$PIN_FILE"
    notify-send "📌 Clipboard" "Pinned current clipboard"
    exit 0
    ;;
  "🧲 Unpin entry")
    to_unpin=$(printf '%s\n' "${pins[@]}" | rofi -dmenu -p "🧲 Unpin" -theme-str "$rofi_theme")
    [[ -z "$to_unpin" ]] && exit 0
    grep -Fxv "$to_unpin" "$PIN_FILE" > "$PIN_FILE.tmp" && mv "$PIN_FILE.tmp" "$PIN_FILE"
    notify-send "🧲 Clipboard" "Unpinned entry"
    exit 0
    ;;
  "🧹 Clear history")
    tmp_pins=$(mktemp)
    cp "$PIN_FILE" "$tmp_pins"
    > "$HIST_FILE"
    mv "$tmp_pins" "$PIN_FILE"
    notify-send "🧹 Clipboard" "History cleared, pins preserved"
    exit 0
    ;;
  "────────────")
    exit 0
    ;;
  *)
    echo -n "$selection" | wl-copy
    notify-send " Clipboard" "Copied: $(echo "$selection" | cut -c -50)..."
    grep -Fxq "$selection" "$HIST_FILE" || echo "$selection" >> "$HIST_FILE"
    exit 0
    ;;
esac
