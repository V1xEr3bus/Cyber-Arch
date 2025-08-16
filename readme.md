# Cyber-Arch: Cyberpunk Arch Linux Rice

> **"Into the dark... with precision."**\
> A visually striking, cyberpunk-themed Arch Linux configuration built on Hyprland

---

## 🖼️ Preview

| Desktop | Rofi Menu | Terminal & Fastfetch |
| ------- | --------- | -------------------- |
|         |           |                      |

More screenshots available in the `screenshots/` folder.

---

## 🚀 Features

- **Hyprland** — Dynamic tiling Wayland compositor with animations
- **Waybar** — Top bar with Unicode workspaces, module integrations
- **SwayNC** — Notification center with toggles and Do Not Disturb
- **Rofi (Wayland)** — Custom themed menus for Wi-Fi, Bluetooth, emoji picker
- **Kitty + Starship** — GPU-accelerated terminal with themed prompt
- **Waypaper + swww** — Toggleable, animated wallpaper control
- **Fish shell** — Smart, fast, and cyber-colored shell with aliases
- **NvChad (Neovim)** — Full IDE experience with LSP, formatting, custom theme
- **Ranger** — Terminal file manager with image/pdf previews
- **Fastfetch** — Fast system info splash
- **Clipse** — Minimal clipboard manager (replaces old Rofi clipboard script)

---

## 🧱 Dependencies

Install these via your AUR helper (`yay`, `paru`, etc):

```bash
yay -S zoxide bat fastfetch cava cmatrix blueman swww \
  wl-clipboard python-pywal playerctl jq fzf rofi-wayland kitty \
  neovim clipse ranger starship
```

Additional optional tools:

- `grim` + `slurp` → For screenshots
- `pamixer` → Volume management
- `blueman` → Bluetooth system tray GUI

---

## 📦 Included Configs

```
.config/
├── cava/             → Audio Visualizer
├── clipse/           → Clipboard manager
├── hypr/             → Hyprland config & scripts
├── kitty/            → Terminal configurations
├── waybar/           → Top bar with modules & style
├── swaync/           → Notification center
├── rofi/             → Custom menus (Wi-Fi, BT, emoji)
├── fish/             → Shell config & abbreviations
├── fastfetch/        → Info splash theme
├── ranger/           → File manager previews
├── nvim/             → Full NvChad setup
.local/share/rofi/    → Rofi Theme (cyberpunk.rasi)
```

---

## ⚙️ Installation

> ⚠️ Manual process. Make backups of existing configs first.

```bash
git clone https://github.com/V1xEr3bus/Cyber-Arch.git
cd Cyber-Arch

# Copy configs to your home directory
cp -r .config/* ~/.config/
cp -r .local/share/rofi ~/.local/share/rofi

# (Optional) Copy wallpapers or scripts as needed
```

After that, log in to Hyprland and enjoy your riced system.

Keep in mind that I use a Nord font, so if you are having visual problems, that's probably the first thing you need to check

---

## 🔧 Custom Scripts

- `wallpaper.sh` — Toggle between 2 wallpaper directories (with SwayNC notification)
- `wifi.sh` — Rofi-based wireless menu
- `bluetooth.sh` — Rofi Bluetooth controller

All scripts are styled consistently to match the cyberpunk theme.

---

## 🧠 Philosophy

Cyber-Arch is built with a hacker/creator mindset:

- Sleek, minimal, readable
- Focused on function **and** vibe
- Everything at your fingertips, keyboard-driven

---

## 👤 Author & Credits

- **Created by:** [V1xEr3bus](https://github.com/V1xEr3bus)
- Inspired by r/unixporn
- Special thanks to open source tools & theme creators

---

## 📜 License

MIT License — Free to use, modify, and share.

---

Enjoy the rice. Welcome to the grid. ⚡

