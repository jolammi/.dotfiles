[ -f $HOME/.zprofile.local ] && source $HOME/.zprofile.local
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
