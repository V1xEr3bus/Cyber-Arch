#!/bin/bash
# ╔═════════════════════════════════════════════════════════════════════╗
# ║ rotate_wallpapers.sh                                                ║
# ║ Automatically rotates wallpapers based on mode (normal / nsfw)      ║
# ║ Includes random transitions and excludes NSFW folder when not in it ║
# ╚═════════════════════════════════════════════════════════════════════╝

WALLPAPER_DIR="$HOME/Media/Pictures/Wallpaper"
NSFW_DIR="$WALLPAPER_DIR/NSFW"
MODE_FILE="$HOME/.config/waypaper/mode"
INTERVAL=3600
LAST_USED_FILE="$HOME/.config/waypaper/last_wallpaper.txt"
transitions=(simple fade left right top bottom wipe grow center outer random wave)

swww init &> /dev/null

[[ ! -f "$MODE_FILE" ]] && echo "normal" > "$MODE_FILE"

wallpapers=()
index=0

while true; do
    mode=$(cat "$MODE_FILE")

    if [[ "$mode" == "nsfw" ]]; then
        current_dir="$NSFW_DIR"
        exclude_path=""
    else
        current_dir="$WALLPAPER_DIR"
        exclude_path="$NSFW_DIR"
    fi

    if [[ "$mode" == "nsfw" ]]; then
        mapfile -t wallpapers < <(find "$current_dir" -type f | shuf)
    else
        mapfile -t wallpapers < <(find "$current_dir" -type f ! -path "$exclude_path/*" | shuf)
    fi

    for wp in "${wallpapers[@]}"; do
        new_mode=$(cat "$MODE_FILE")
        if [[ "$new_mode" != "$mode" ]]; then
            break
        fi

        transition_type=${transitions[$RANDOM % ${#transitions[@]}]}
        swww img "$wp" --transition-type "$transition_type" --transition-fps 60 --transition-duration 2
        echo "$wp" > "$LAST_USED_FILE"
        sleep $INTERVAL
    done
done
