#!/bin/bash

# ╔════════════════════════════════════════════════════╗
# ║        Rofi Bluetooth Manager for Arch Linux       ║
# ║         Connects, disconnects, and trusts!         ║
# ╚════════════════════════════════════════════════════╝

icon_connected=" ✓"
icon_disconnected=" ✗"

declare -A mac_names

# Get paired devices
while read -r line; do
  [[ $line =~ ^Device ]] || continue
  mac=$(awk '{print $2}' <<< "$line")
  name=$(cut -d ' ' -f3- <<< "$line")
  mac_names["$mac"]="$name"
done < <(echo -e 'paired-devices' | bluetoothctl)

# Get all known devices
while read -r line; do
  [[ $line =~ ^Device ]] || continue
  mac=$(awk '{print $2}' <<< "$line")
  name=$(cut -d ' ' -f3- <<< "$line")
  mac_names["$mac"]="$name"
done < <(echo -e 'devices' | bluetoothctl)

if [[ ${#mac_names[@]} -eq 0 ]]; then
  notify-send " Bluetooth" "No devices found"
  exit 1
fi

entries=()
for mac in "${!mac_names[@]}"; do
  name="${mac_names[$mac]}"
  [[ -z "$name" ]] && name="Unknown Device"
  status=$(bluetoothctl info "$mac" | grep -q "Connected: yes" && echo "$icon_connected" || echo "$icon_disconnected")
  entries+=("$status $name [$mac]")
done

selection=$(printf '%s\n' "${entries[@]}" | rofi -dmenu \
  -p " Bluetooth Devices" \
  -theme-str 'window { location: center; width: 50%; height: 50%; border-radius: 15px; background-color: #080808BF; } listview { dynamic: true; }')

[[ -z "$selection" ]] && exit 0

mac=$(grep -oP '(?<=\[)[^]]+(?=\])' <<< "$selection")
name=$(sed -E 's/^[^ ]+ (.+) \[.*/\1/' <<< "$selection")

rename_prompt="Rename $name? Leave empty to skip."
new_name=$(rofi -dmenu -p "$rename_prompt")
if [[ -n "$new_name" ]]; then
  bluetoothctl system-alias "$new_name" > /dev/null
  notify-send " Renamed" "$name → $new_name"
fi

if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
  bluetoothctl disconnect "$mac" > /dev/null
  notify-send " $name" "Disconnected"
else
  bluetoothctl trust "$mac" > /dev/null
  bluetoothctl connect "$mac" > /dev/null
  notify-send " $name" "Connected & Trusted"
fi
