# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

IN_VIM=$(ps -p $PPID -o comm= | grep -qsE '[gm]?vim' && echo 1)

# Use vim bindings, except when we're actually in vim
[ -z $IN_VIM ] && bindkey -v || bindkey -e

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export EDITOR='nvim'

ZSH_THEME="oxide"

source ~/.config/zsh/.zsh_aliases

# change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${keymap} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${keymap} == main ]] ||
#        [[ ${keymap} == viins ]] ||
#        [[ ${keymap} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -n zle-keymap-select

# Zoxide (better cd)
PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"


# This removes the newline between each prompt
print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit
prompt pure

EXCLUDED=('*/.git' '*/.cache' './.local/share')
cmd=$(printf -- "-path '%s' -o " "${EXCLUDED[@]}" | cut -d' ' -f1-$((${#EXCLUDED[@]} * 3 - 1)))
export FZF_DEFAULT_COMMAND="find \( $cmd \) -prune -o \! -type d -printf '%P\n'"
