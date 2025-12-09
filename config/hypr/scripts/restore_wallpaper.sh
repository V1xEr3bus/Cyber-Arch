#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  Restore last wallpaper (Waypaper + swww) for Hyprland sessions  ║
# ║                                                                  ║
# ║  Purpose : Start/verify swww-daemon, then restore Waypaper state ║
# ║  Requires: swww, waypaper, Hyprland                              ║
# ║  Notes   : Falls back to ~/.config/waypaper/last_wallpaper       ║
# ║  License : MIT (adjust as you wish)                              ║
# ╚══════════════════════════════════════════════════════════════════╝
set -euo pipefail

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

if [[ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  sig_candidates=(/tmp/hypr/*/.socket.sock)
  if [[ -e "${sig_candidates[0]:-}" ]]; then
    export HYPRLAND_INSTANCE_SIGNATURE
    HYPRLAND_INSTANCE_SIGNATURE="$(basename "$(dirname "${sig_candidates[0]}")")"
  fi
fi

if ! pgrep -x swww-daemon >/dev/null 2>&1; then
  /usr/bin/swww-daemon --format xrgb >/dev/null 2>&1 &
fi

for _ in {1..60}; do
  if /usr/bin/swww query >/dev/null 2>&1; then
    break
  fi
  sleep 0.25
done

if ! /usr/bin/waypaper --restore >/dev/null 2>&1; then
  last_conf="${XDG_CONFIG_HOME:-$HOME/.config}/waypaper/last_wallpaper"
  if [[ -f "$last_conf" ]]; then
    mapfile -t lines < "$last_conf"
    img="${lines[0]}"
    mode="${lines[1]:-fill}"
    if [[ -f "$img" ]]; then
      /usr/bin/swww img "$img" --resize "$mode" --transition-type none >/dev/null 2>&1 || true
    fi
  fi
fi
