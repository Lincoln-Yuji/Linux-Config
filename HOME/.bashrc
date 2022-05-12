#    __  __         _               _
#   |  \/  |_   _  | |__   __ _ ___| |__  _ __ ___
#   | |\/| | | | | | '_ \ / _` / __| '_ \| '__/ __|
#   | |  | | |_| | | |_) | (_| \__ \ | | | | | (__
#   |_|  |_|\__, | |_.__/ \__,_|___/_| |_|_|  \___|
#           |___/

# ~/.bashrc: executed by bash(1) for non-login shells.

# Personal exports definitions
export HISTCONTROL=ignoreboth            # Ignore duplicate lines or lines starting with space in the history
export BROWSER="firefox"                 # Firefox is my default browser
# export EDITOR="/usr/bin/emacs -a -n"   # Emacs is my default Text Editor
# export VISUAL="/usr/bin/emacs -a -n"   # $VISUAL will use Emacs in GUI mode as well
export EDITOR="/usr/local/bin/nvim"      # Neovim as default text editor
export VISUAL="/usr/local/bin/nvim"
export TERM="xterm-256color"             # Pretty colors to terminal

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
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Acceleration!!!
xset r rate 300 50

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

alias poweroff='$HOME/Scripts/shutdown.sh'
alias ccc='$HOME/Scripts/clang-compile-commands.sh'

# Source my fzf configs
if [ -f ~/.config/fzf/fzf-config.sh ]; then
    source ~/.config/fzf/fzf-config.sh
fi

# Genereic function created to make life easier when I need to extract some files
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

# Functions in development:
# function memram() {
#     echo "======================="
#     free --mega | awk '/^Mem/ {print "  Used:      " $3 " MB" "\n" "  Available: " $7 " MB"}'
#     echo "======================="
# }

# function diskuse() {
#     df -h | grep '/dev/sda5' | awk '{print "Total: " $2 "\n" "Used:  " $3 }'
# }

# function cputemp() {
#     sensors | awk '/^temp/ {print $1 $2}' | sed "s/temp/Core /g"
# }
