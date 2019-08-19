# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ash/.fzf/bin* ]]; then
  export PATH="$PATH:/home/ash/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ash/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ash/.fzf/shell/key-bindings.zsh"

