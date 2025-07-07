# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# History settings
export HISTFILE="${XDG_CACHE_HOME}/zsh/zhistory"
export HISTSIZE=1500
export SAVEHIST=1500
export HISTDUP='erase'

if [[ ! -f ${HISTFILE} ]]; then
    touch ${HSTFILE}
fi

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Start settings
setopt autocd extendedglob nomatch notify # ZSH options
unsetopt beep                             # Turn off beeping sounds
autoload -U colors && colors              # Enable color

# Setting prompt
# This function gives us the current git branch in the current repository
function parse_git_branch() {
    current_branch="$(git branch --show-current 2> /dev/null)"
    [ -n "$current_branch" ] && echo "(${current_branch})"
}
setopt PROMPT_SUBST
local CR=$'\n'
PS1="[🐧]%f[%F{cyan}%n@%m %f%F{blue}%~%f] %F{red}\$(parse_git_branch)${CR}%f❱❱❱ "

# Auto completion (Amazing tab completion btw)
autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zmodload zsh/complist

compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump"

_comp_options+=(globdots)

# Enable vi mode
bindkey -v
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1

# Verify if fzf is installed. If it is, then load the fzf-zsh script extension
# [Ctrl+r]: access shell history
# [Ctrl+t]: access file tree from current directory
[[ -n "$(which fzf)" ]] && source <(fzf --zsh)

# Custom Functions
# [Ctrl+a]: access my aliases defined for ZSH
function search_zsh_aliases() {
    local searched_alias="$(cat ~/.config/zsh/.zshrc | grep '^[[:blank:]]*alias' | sed -e 's/^[[:blank:]]*alias[[:blank:]]//' | fzf | sed -e 's/=.*//')"
    BUFFER="${BUFFER}${searched_alias}"
    CURSOR=${#BUFFER}
}
[[ -n "$(which fzf)" ]] && zle -N search_zsh_aliases && bindkey '^a' search_zsh_aliases

# Changing the prompt cursor for different vi modes (Taken from Luke Smith video)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# My aliases
alias xx='clear'
alias nv='nvim'
alias zj='zellij'
alias rsbook='rustup docs --book'

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -AlhFGX'
alias la='ls -A'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rg-telescope='rg --context=4'

alias free='free --mega'
alias du='du -sh'
alias df='df -h'
alias br='br -spd'

# Enabling zsh plugins

# Arch
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
# ssource /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null

# Fedora
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
