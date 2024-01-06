alias venvi='source venv/bin/activate'
# alias teevenvi=python -m venv venv'
alias delmerged='git fetch && git branch -a && echo "\n\n" && git remote prune origin && git checkout master && echo "\n\n" && git branch --merged | grep -Ev "\*|master|development" | xargs -p git branch -d && echo "\n\n" && git branch -a'
alias c=clear
alias clock='TZ=Europe/Helsinki tty-clock -bc -C7 -f "  %t%A %d %B %Y%n%t%t%tDay %j | Week %W"'
alias bat=batcat
alias lg=lazygit
function cheat_func(){
    curl cheat.sh/$1
}

alias cheat=cheat_func
alias asd="git status"

function git_worktree_add(){
    git worktree add ./worktrees/"$1" -b "$1"
}

alias gwa=git_worktree_add
alias gitdf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# function to set up local git identity
setlocalgitidentity () {
        git config --local user.name ${1}
        git config --local user.email ${2}
}

# Install go if not installed

GO_VERSION=1.21.5
install_go () {
    if [[ $(go version || true) == "go version go${GO_VERSION} linux/amd64" ]]; then
        echo up to date
        return
    fi
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    go version
}

review () {
    commitish="$1"
    #go to project root to get folder name
    cd "$(git rev-parse --show-toplevel)" || return 1
    project="$(basename "$(pwd)")"

    # create  worktree to dump
    new_wt="$HOME/wt-dump/$project/$commitish"
    git worktree add "$new_wt" "$commitish"

    echo "$new_wt"
    cd "$new_wt"
}
compdef _git review=git checkout

teevenvi () {
  asd=$(pyenv versions | fzf | grep -oP "(\d+\.\d+\.\d+)")

  if [ -z "$asd" ]
  then
    echo "Aborted."
    return 1
  else
    echo "Activating Python ${asd} shell with pyenv"
    pyenv shell $asd
    echo "Activated."
  fi
  echo "Creating venv with Python ${asd}"
  python -m venv venv
  echo "Created."
  source venv/bin/activate
  echo "Venv activated"

  pyenv shell --unset
  echo "Pyenv shell deactivated."
}
