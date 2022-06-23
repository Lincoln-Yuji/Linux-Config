#    __  __         _               _
#   |  \/  |_   _  | |__   __ _ ___| |__  _ __ ___
#   | |\/| | | | | | '_ \ / _` / __| '_ \| '__/ __|
#   | |  | | |_| | | |_) | (_| \__ \ | | | | | (__
#   |_|  |_|\__, | |_.__/ \__,_|___/_| |_|_|  \___|
#           |___/

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize
HISTSIZE=1000
HISTFILESIZE=1500

shopt -s autocd # Allows to cd into a directory by just typing the path

# Enable vi mode
set -o vi

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
    [ -z ${current_branch} ] && echo "None" || echo "${current_branch}"
}

# Customizing the shell prompt
if [ "$color_prompt" = yes ]; then
    PBLUE="\[\033[01;34m\]"
    PNORM="\[\033[00m\]"
    PWARN="\[\e[91m\]"
    PS1="${PBLUE} : ${PNORM}[${PBLUE}\w${PNORM}]${PWARN} (\$(parse_git_branch)) ${PNORM}\n❱❱❱ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Source cargo environment and add rust binaries to PATH
[ -f "${CARGO_HOME}/env" ] && source "${CARGO_HOME}/env"
[ -d "${CARGO_HOME}/bin" ] && PATH="${CARGO_HOME}/bin:${PATH}"

# My aliases
alias xx='clear'
alias nv='nvim'
alias zz='~/.config/zz-config-setup'
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
alias ll='ls -AlhFGX'
alias la='ls -A'
alias br='br -spd'
alias wttr='curl wttr.in'

