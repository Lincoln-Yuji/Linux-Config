#  ____             __ _ _      
# |  _ \ _ __ ___  / _(_) | ___ 
# | |_) | '__/ _ \| |_| | |/ _ \
# |  __/| | | (_) |  _| | |  __/
# |_|   |_|  \___/|_| |_|_|\___|

# Defining evironmental variables
export HISTCONTROL=ignoreboth  # Ignore duplicate lines or lines starting with space
export BROWSER="firefox"       # Default browser
export EDITOR="nvim"           # Default editor
export VISUAL="nvim"
export TERM="xterm-256color"   # Pretty colors to terminal
export TERMINAL="alacritty"    # Default terminal emulator
export ZDOTDIR="$HOME/.config/zsh" # ZSH dot directory

# XDG Base Directory specification
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export CARGO_HOME="$HOME/.local/rust/cargo"    # Binaries and Environment for rust projects
export RUSTUP_HOME="$HOME/.local/rust/rustup"  # Rust up location

# export QT_QPA_PLATFORMTHEME="qt5ct" # Using qt5ct setting for all Qt5 apps

export PATH="$HOME/.local/bin:${PATH}" # Add user binaries to PATH

# Sourcing bashrc
# [[ -f ~/.bashrc ]] && source ~/.bashrc

# Source cargo environment and add rust binaries to PATH
# (It seems that just sourcing the env already includes the cargo binaries into $PATH)
[ -f "${CARGO_HOME}/env" ] && source "${CARGO_HOME}/env"

## Autostart commands
setxkbmap -layout br
# setxkbmap -option 'caps:swapescape'
# xset r rate 300 50

