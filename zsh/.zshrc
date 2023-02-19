source ~/.config/zsh/.zsh_aliases
# Set up the prompt
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

export EDITOR='nvim'

ZSH_THEME="oxide"


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
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print -r "$@";
}
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit

EXCLUDED=('*/.git' '*/.cache' '*/.local' '*/.virtualenvs' '*/.fonts')
cmd=$(printf -- "-path '%s' -o " "${EXCLUDED[@]}" | cut -d' ' -f1-$((${#EXCLUDED[@]} * 3 - 1)))
export FZF_DEFAULT_COMMAND="find \( $cmd \) -prune -o \! -type d -printf '%P\n'"
prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
[ -z $VIRTUAL_ENV ] && source /home/mhd/.local/bin/virtualenvwrapper_lazy.sh

LFCD="$HOME/.config/lf/lfcd.sh"                                #  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
bindkey -s '^o' 'lfcd\n'  # zsh
