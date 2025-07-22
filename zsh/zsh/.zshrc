# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# History settings

export HISTPATH="${XDG_CACHE_HOME}/zsh"
export HISTFILE="${XDG_CACHE_HOME}/zsh/zhistory"
export HISTSIZE=1500
export SAVEHIST=1500
export HISTDUP='erase'

if [[ ! -d "$HISTPATH" ]]; then
    mkdir -p "$HISTPATH"
    touch "$HISTFILE"
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
compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zmodload zsh/complist

_comp_options+=(globdots)

# My aliases
alias xx='clear'
alias nv='nvim'
alias zj='zellij'
alias rsbook='rustup docs --book'

alias ls='ls --color=auto --group-directories-first'
# alias ll='ls -AlhFGX'
alias ll='eza -la --icons=auto --group-directories-first'
alias la='ls -A'

alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rg-telescope='rg --context=4'

alias free='free --mega'
alias du='du -sh'
alias df='df -h'
alias br='br -spd'

# Vi Mode
source "${XDG_CONFIG_HOME}/zsh/vimode.sh"

# Fzf-Zsh scripts
source "${XDG_CONFIG_HOME}/zsh/fzf-config.sh"

# Arch
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
# ssource /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null

# Fedora
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
