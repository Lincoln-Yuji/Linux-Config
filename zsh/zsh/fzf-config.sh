# Verify if fzf installed. Exit if it's not...
[[ ! -n "$(which fzf)" ]] && exit 1

# [Ctrl+r]: prompts shell history
# [Ctrl+t]: prompts *files* inside tree from current directory
# [Alt+c]:  prompts *directories* inside tree from current directory

declare file_preview="bat --theme='Visual Studio Dark+' --color=always -n --line-range :200"
declare path_preview="eza -la --color=always --tree"

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type=d"

export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border --color=hl:#2dd4bf'
export FZF_CTRL_T_OPTS="--preview \"[[ -d {} ]] && ${path_preview} {} || ${file_preview} {}\" --preview-window=down:55%"
export FZF_ALT_C_OPTS="--preview '${path_preview} {}' --preview-window=right:60%"

# Load fzf-zsh script extension
eval "$(fzf --zsh)"

# Custom Functions
# [Ctrl+H]: history (similar to Ctrl+R) but with EXACT search matches
function search_exact_history() {
    local searched_command="$(history 1 | fzf --exact | sed 's/^\s*[0-9]*\s*//g')"
    BUFFER="${BUFFER}${searched_command}"
    CURSOR=${#BUFFER}
}
zle -N search_exact_history && bindkey '^h' search_exact_history
