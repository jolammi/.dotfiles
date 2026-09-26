## ↓↓↓ Set up direnv and keep p10k instant prompt sane ↓↓↓
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
## ↑↑↑ direnv and p10k configuration ↑↑↑


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.custom_zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux z docker docker-compose python zsh-syntax-highlighting zsh-autosuggestions timewarrior)
zstyle ':omz:plugins:docker' legacy-completion yes


source $ZSH/oh-my-zsh.sh

################## User configs ################################

# p10k setup
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

[[ ! -f $HOME/.dotfileconfig ]] || source $HOME/.dotfileconfig

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d $PYENV_ROOT/shims ]] && export PATH="$PYENV_ROOT/shims:$PATH"
if [[ -x "$PYENV_ROOT/bin/pyenv" ]]; then
    pyenv() {
        unset -f pyenv
        eval "$("$PYENV_ROOT/bin/pyenv" init - --no-rehash zsh)"
        pyenv "$@"
    }
fi


# ADD GO TO PATH
export PATH=$PATH:/usr/local/go/bin
# Go executables
export PATH=$PATH:$HOME/go/bin

# nvm setup
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazy load node related stuff
load_nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { load_nvm; nvm "$@"; }
node() { load_nvm; node "$@"; }
npm() { load_nvm; npm "$@"; }
npx() { load_nvm; npx "$@"; }

# Add bin folders to path
[ -d "$HOME/bin" ] || mkdir -p "$HOME/bin"
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

[ -d "$HOME/.local/bin" ] || mkdir -p "$HOME/.local/bin"
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

export PATH="$HOME/.local/scripts:$PATH"

[ -f $HOME/.local_confs ] && source $HOME/.local_confs
# autoload -U compinit
#compinit -i

eval "$(task --completion zsh)"
