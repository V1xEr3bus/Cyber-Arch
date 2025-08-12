#!/bin/bash
# ╔═════════════════════════════════════════════════════════════════════╗
# ║ change_wallpaper.sh                                                 ║
# ║ Manually rotates wallpapers based on mode (normal / nsfw)           ║
# ║ No repeats until full cycle                                         ║
# ╚═════════════════════════════════════════════════════════════════════╝

WALLPAPER_DIR="$HOME/Media/Pictures/Wallpaper"
NSFW_DIR="$WALLPAPER_DIR/NSFW"
MODE_FILE="$HOME/.config/waypaper/mode"
USED_DIR="$HOME/.config/waypaper/used"
LAST_USED_FILE="$HOME/.config/waypaper/last_wallpaper.txt"
transitions=(simple fade left right top bottom wipe grow center outer random wave)

mkdir -p "$USED_DIR"
[[ -f "$MODE_FILE" ]] || echo normal > "$MODE_FILE"
mode=$(<"$MODE_FILE")
used_file="$USED_DIR/used_${mode}.txt"
touch "$used_file"

if [[ "$mode" == "nsfw" ]]; then
  find_dir=("$NSFW_DIR")
  find_args=(-type f)
else
  find_dir=("$WALLPAPER_DIR")
  find_args=(-type f ! -path "$NSFW_DIR/*")
fi

mapfile -t all_wps < <(find "${find_dir[@]}" "${find_args[@]}" | shuf)

candidates=()
for wp in "${all_wps[@]}"; do
  ! grep -Fxq -- "$wp" "$used_file" && candidates+=("$wp")
done

if (( ${#candidates[@]} == 0 )); then
  > "$used_file"
  candidates=("${all_wps[@]}")
fi

selection="${candidates[RANDOM % ${#candidates[@]}]}"
transition=${transitions[$RANDOM % ${#transitions[@]}]}

swww img "$selection" --transition-type "$transition" --transition-fps 60 --transition-duration 2

echo "$selection" >> "$used_file"
echo "$selection" > "$LAST_USED_FILE"
