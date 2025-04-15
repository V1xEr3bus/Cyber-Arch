#!/bin/bash

# ╔════════════════════════════════════════════════════╗
# ║             Rofi Wi-Fi Manager for Arch Linux       ║
# ║     Lists, connects, and manages saved networks      ║
# ╚════════════════════════════════════════════════════╝

read -r -d '' rofi_theme <<EOF
* {
  margin: 0;
  padding: 0;
  spacing: 0;
  font: "JetBrainsMono Nerd Font 16";
}
window {
  location: center;
  width: 50%;
  height: 50%;
  border-radius: 15px;
  background-color: #080808BF;
}
listview {
  dynamic: true;
}
EOF

icon_connected=" ✓"
icon_disconnected=" ✗"

declare -A wifi_map

# Get all visible networks
mapfile -t scan_results < <(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi list)

for entry in "${scan_results[@]}"; do
  IFS=':' read -r active ssid signal <<< "$entry"
  [[ -z "$ssid" ]] && continue
  icon="$icon_disconnected"
  [[ "$active" == "yes" ]] && icon="$icon_connected"
  wifi_map["$ssid"]="$entry"
  entries+=("$icon $ssid ($signal%)")
done

# Prompt for network selection
selection=$(printf '%s\n' "${entries[@]}" | rofi -dmenu -p " Wi-Fi Networks" -theme-str "$rofi_theme")
[[ -z "$selection" ]] && exit 0

# Extract SSID
ssid=$(sed -E 's/^.+ (.+) \([0-9]+%\)$/\1/' <<< "$selection")

# Check if saved
nmcli connection show "$ssid" &>/dev/null
if [[ $? -eq 0 ]]; then
  # Toggle connection
  if nmcli -t -f active,ssid dev wifi | grep -q "^yes:$ssid"; then
    nmcli con down "$ssid"
    notify-send " $ssid" "Disconnected"
  else
    nmcli con up "$ssid"
    notify-send " $ssid" "Connected"
  fi
else
  # Ask for password and connect
  password=$(rofi -dmenu -password -p "Password for $ssid")
  [[ -z "$password" ]] && exit 1
  nmcli dev wifi connect "$ssid" password "$password" && \
    notify-send " $ssid" "Connected & Saved" || \
    notify-send " $ssid" "Failed to connect"
fi
