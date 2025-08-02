#  ____             __ _ _      
# |  _ \ _ __ ___  / _(_) | ___ 
# | |_) | '__/ _ \| |_| | |/ _ \
# |  __/| | | (_) |  _| | |  __/
# |_|   |_|  \___/|_| |_|_|\___|

# Defining evironmental variables
export HISTCONTROL=ignoreboth  # Ignore duplicate lines or lines starting with space

# ZSH dot files directory
export ZDOTDIR="$HOME/.config/zsh"
export SHELL='/bin/zsh'

# XDG Base Directory specification
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export CARGO_HOME="${HOME}/.local/rust/cargo"    # Binaries and Environment for rust projects
export RUSTUP_HOME="${HOME}/.local/rust/rustup"  # Rust up location

export PATH="${HOME}/.local/bin:${PATH}" # Add user binaries to PATH

# Source cargo environment and add rust binaries to PATH
# (It seems that just sourcing the env already includes the cargo binaries into $PATH)
[ -f "${CARGO_HOME}/env" ] && source "${CARGO_HOME}/env"

# Autostart commands
# setxkbmap -layout br
# setxkbmap -option 'caps:swapescape'
# xset r rate 300 50
