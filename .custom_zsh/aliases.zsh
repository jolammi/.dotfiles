alias venvi='source venv/bin/activate'
alias teevenvi='python -m venv venv'
alias delmerged='git fetch && git branch -a && echo "\n\n" && git remote prune origin && git checkout master && echo "\n\n" && git branch --merged | grep -Ev "\*|master|development" | xargs -p git branch -d && echo "\n\n" && git branch -a'
alias c=clear
alias clock='TZ=Europe/Helsinki tty-clock -bc -C7 -f "  %t%A %d %B %Y%n%t%t%tDay %j | Week %W"'
alias bat=batcat

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
