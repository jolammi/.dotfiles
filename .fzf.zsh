# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jolammi/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jolammi/.fzf/bin"
fi

source <(fzf --zsh)
