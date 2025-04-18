alias venvi='source venv/bin/activate'
# alias teevenvi=python -m venv venv'
alias c=clear
alias clock='TZ=Europe/Helsinki tty-clock -bc -C7 -f "  %t%A %d %B %Y%n%t%t%tDay %j | Week %W"'
alias bat=batcat
alias lg=lazygit
alias lgdf='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'
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
alias asddf="gitdf status"

# function to set up local git identity
setlocalgitidentity () {
        git config --local user.name ${1}
        git config --local user.email ${2}
}

# Install go if not installed

GO_VERSION=1.22.3
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

git_hard_reset () {
    if ! $(git rev-parse --show-toplevel 2> /dev/null); then
        echo "Not inside a git repo, aborting"
        return 1
    fi

    echo -n "Press 'y' to continue with git hard reset to origin/$(git_main_branch) > "
    read -q key
    echo
    if [[ "$key" == "y" ]]; then
        echo "Fetching origin..."
        git fetch origin
        echo "Hard resetting to fresh origin/$(git_main_branch)"
        git reset --hard origin/$(git_main_branch)
    else
        echo "'y' not pressed. Aborting."
        return 1
    fi
}
alias ghr=git_hard_reset
alias grh='ghr'

compdef _git review=git checkout

alias isonow="date +'%Y-%m-%dT%H:%M:%S%:z'"


