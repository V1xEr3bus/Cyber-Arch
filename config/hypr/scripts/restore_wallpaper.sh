#!/bin/bash
# ╔════════════════════════════════════════════╗
# ║   Restore the last wallpaper using Waypaper ║
# ║   Waits for swww-daemon to be ready first  ║
# ╚════════════════════════════════════════════╝

# Wait for swww to be ready
while ! pgrep -x "swww-daemon" > /dev/null; do
    sleep 0.5
done

# Restore with waypaper
waypaper --restore
e
