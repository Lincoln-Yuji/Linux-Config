#    __  __         _               _
#   |  \/  |_   _  | |__   __ _ ___| |__  _ __ ___
#   | |\/| | | | | | '_ \ / _` / __| '_ \| '__/ __|
#   | |  | | |_| | | |_) | (_| \__ \ | | | | | (__
#   |_|  |_|\__, | |_.__/ \__,_|___/_| |_|_|  \___|
#           |___/

# Personal exports definitions
export HISTCONTROL=ignoreboth            # Ignore duplicate lines or lines starting with space in the history
export BROWSER="firefox"                 # Firefox is my default browser
export EDITOR="nvim"                     # Neovim as default text editor
export VISUAL="nvim"
export TERM="xterm-256color"             # Pretty colors to terminal

export XDG_DATA_HOME="$HOME/.local/share"    # Clean Home
export XDG_CONFIG_HOME="$HOME/.config"       # Clean Home

export CARGO_HOME="$HOME/.local/share/rust/.cargo" # Binaries and Environment for rust projects

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize
HISTSIZE=1000
HISTFILESIZE=1500

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Uncomment the following line will force a colored prompt even in abnormal circuntances
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# This function gives us the current git branch in the current repository
parse_git_branch() {
    current_branch="$(git branch --show-current 2>/dev/null)"
    if [ -z ${current_branch} ]
    then
        echo "None"
    else
        echo "${current_branch}"
    fi
}

# Customizing the shell prompt
if [ "$color_prompt" = yes ]; then
    PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]\[\e[91m\]' # Prompt
    PS1="$PS1 ($(parse_git_branch))\[\033[00m\]\n> " # Git branch, if there is a git repo
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# My aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias free='free --mega'
alias du='du -sh'
alias df='df -h'
alias ll='ls -alhF'
alias la='ls -A'
alias br='br -spd'
alias wttr='curl wttr.in'

SCRIPT="$HOME/Scripts"
if [ -d "$SCRIPT" ]; then
    alias poweroff="$SCRIPT/shutdown.sh"
    alias ccc="$SCRIPT/clang-compile-commands.sh"
fi

# Source my fzf configs
if [ -f ~/.config/fzf/fzf-config.sh ]; then
    source ~/.config/fzf/fzf-config.sh
fi

# Source cargo environment and add rust binaries to PATH
if [ -d "${CARGO_HOME}/env" ]; then
    source "${CARGO_HOME}/env"
fi
if [ -d "${CARGO_HOME}/bin" ]; then
    PATH="${CARGO_HOME}/bin:${PATH}"
fi

# Generic decompressor
function extract() {
    if [ -f $1 ]
    then
        case $1 in
            *.tar.gz) tar -xzvf $1 ;;
            *.tar.xz) tar -xf $1   ;;
            *.zip)    unzip $1     ;;
            # *.rar     unrar x $1   ;;
            *) echo "'$1' can't be extracted via this command...";;
        esac
    else
        echo "This file does not exist"
    fi
}
