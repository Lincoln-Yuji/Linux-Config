# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Start settings
setopt autocd extendedglob nomatch notify # ZSH options
setopt hist_ignore_dups
setopt hist_ignore_space
unsetopt beep                             # Turn off beeping sounds
autoload -U colors && colors              # Enable color

# Setting prompt
# This function gives us the current git branch in the current repository
function parse_git_branch() {
    current_branch="$(git branch --show-current 2>/dev/null)"
    [ -z ${current_branch} ] && echo "None" || echo "${current_branch}"
}
setopt PROMPT_SUBST
NEWLINE=$'\n'
PS1="%F{blue} : %f[%F{cyan}%n@%m %f%F{blue}%~%f] %F{red}(\$(parse_git_branch))${NEWLINE}%f❱❱❱ "

# History settings
HISTFILE=~/.cache/zsh/history
HISTSIZE=1500
SAVEHIST=1500

# Auto completion (Amazing tab completion btw)
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Enable vi mode
bindkey -v
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1

# Changing the prompt cursor for different vi modes (Taken from Luke Smith video)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
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

# Enabling zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
