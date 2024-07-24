# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# History settings
export HISTFILE="${XDG_CACHE_HOME}/zsh/zhistory"
export HISTSIZE=1500
export SAVEHIST=1500
export HISTDUP='erase'

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
# The history can be accessed via 'Ctrl+r' keybind
[[ -n "$(which fzf)" ]] && source <(fzf --zsh)

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
alias zz='~/.config/zz-config-setup'
alias rsbook='rustup docs --book'

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias free='free --mega'
alias du='du -sh'
alias df='df -h'
alias ll='ls -AlhFGX'
alias la='ls -A'
alias br='br -spd'
alias wttr='curl wttr.in'

alias ytf='youtube-dl -F' # Check the formats available
alias ytd='youtube-dl -f' # Download ONLY the specified format (i.e 22)
alias ytp='youtube-dl -i -f mp4 --yes-playlist' # Download an entire playlist

# Enabling zsh plugins

# Arch
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null

# Fedora
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
