if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

# ========== Startup Tools ==========
set -U fish_greeting
fastfetch
starship init fish | source
zoxide init fish | source

# ========== Daily Status ==========
echo -e "\n\033[1;36m╭───────────────[ SYSTEM STATUS ]───────────────╮\033[0m"
echo -e "\033[1;36m│ Date:      \033[0m"(date "+%A, %d %B %Y  %H:%M")
echo -e "\033[1;36m│ Wallpaper: \033[0m"(cat ~/.config/waypaper/mode)
echo -e "\033[1;36m╰───────────────────────────────────────────────╯\033[0m"

# Inspirational quote via API
echo -e "\033[1;33m✦ Quote of the Day:\033[0m"
curl -s https://zenquotes.io/api/random | jq -r '.[0].q + " — " + .[0].a'

# ========== Aliases ==========
alias v='nvim'
alias untar='tar -xvzf'
alias mirror='sudo reflector --age 12 --protocol https --sort rate --number 15 --save /etc/pacman.d/mirrorlist'
alias bye='sudo shutdown --no-wall -h now'
alias keyb='sudo systemctl restart kmonad.service'

# File & Directory Navigation
alias ls='exa -l'
alias ll='exa -alh'
alias tree='exa --tree'

# File Reading
alias cat='bat'

# Notifications
alias swaync-reload='swaync-client -R'

# FoundryVTT
alias dnd='node ~/FoundryVTT/resources/app/main.js -dataPath=~/FoundryVTT/Foundry-Data/'

# System Hygiene
alias clean-pacman='sudo pacman -Rns (pacman -Qtdq)'
alias update='yay -Syu'
alias fix-audio='pulseaudio -k && pulseaudio --start'

# Directory Bookmarks
alias docs='z ~/Documents'
alias wpics='z ~/Media/Pictures/Wallpaper'

# Wallpaper toggle function
function toggle_wallpaper
    ~/.config/hypr/scripts/toggle_wallpaper_mode.sh
end

# ========== Git Abbreviations ==========
abbr --add gco 'git checkout'
abbr --add gcm 'git commit -m'
abbr --add gst 'git status'
abbr --add gpo 'git push origin'
abbr --add gl 'git pull'
abbr --add lg 'lazygit'

alias fix-audio='pulseaudio -k && pulseaudio --start'

# Directory Bookmarks
alias docs='z ~/Documents'
alias wpics='z ~/Media/Pictures/Wallpaper'

# Wallpaper toggle function
function toggle_wallpaper
    ~/.config/hypr/scripts/toggle_wallpaper_mode.sh
end

# ========== Git Abbreviations ==========
abbr --add gco 'git checkout'
abbr --add gcm 'git commit -m'
abbr --add gst 'git status'
abbr --add gpo 'git push origin'
abbr --add gl 'git pull'
abbr --add lg 'lazygit'


thefuck --alias | source
