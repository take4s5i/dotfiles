#!/bin/sh

## LANG
export LANG=ja_JP.utf8

## path
export PATH=$PATH:/c/PROGRA~2/Git/bin
export PATH=$PATH:/c/bin
export PATH=$PATH:~/bin

## less
export LESS="-iMRS --shift 5"

## alias
alias tmux="TERM=xterm-256color tmux"

## alias for git
alias gs='git status -s'

alias gl='git graph'
alias glx='git graph --all -15'
alias gla='git graph --all'
alias glt='git graph --all --since="today"'
alias gly='git graph --all --since="yesterday"'
alias gl3='git graph --all --since="3 days ago"'
alias gl4='git graph --all --since="4 days ago"'
alias gl5='git graph --all --since="5 days ago"'
alias gl6='git graph --all --since="6 days ago"'
alias glw='git graph --all --since="a week ago"'

alias ga='git add'
alias gap='git add -p'
alias gae='git add -e'

alias gco='git checkout'
alias gcod='git checkout develop'
alias gcom='git checkout master'

alias gm='git merge'
alias gmff='git merge --ff'
alias gmnf='git merge --no-ff'

alias gr='git rebase'
alias grd='git rebase develop'
alias gri='git rebase -i'
alias grid='git rebase -i develop'

alias gc='git commit'
alias gcv='git commit -v'
alias gca='git commit -v --amend'

alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gbd='git branch -d'


## prompt
git-info() {
    git rev-parse HEAD > /dev/null 2>&1 || return 1

    local BRANCH=$(git rev-parse --abbrev-ref HEAD)
#    local STAT=$(git status -s | cut -c1 |grep -v "!" |tr " MADRCU\?" "\@\*\+\-RCU\?" | uniq -c | tr -d "\n")
    echo -n "[${BRANCH}]"

}
#export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[1;34m\]$(git-info)\[\033[00m\]\n\$ '
export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\]\[\033[00m\]\n\$ '

## function 

# opd : [op]en [d]irectory
# open directory with windows explorer
opd(){
    if [ $# -eq 0 ] ; then
        explorer $(pwd -W | tr '/' '\\')
    else
        for d in $@ ; do
            explorer "$((cd $d ; pwd -W) | tr '/' '\\')"
        done
    fi
}

# gcd : git cd
# change current directory to the relative path from root of git directory
gcd(){
    # return if out of git repository.
    git rev-parse HEAD > /dev/null 2>&1 || return 1

    DIR=$1
    if [ "${DIR:0:1}" != "/" ] ; then
        cd $DIR
    else
        cd "$(git rev-parse --show-toplevel)$1"
    fi
}
# this completion work when pass a relative path to gcd.
complete -A directory gcd

gem(){
    cmd "/C gem.bat ${*}"
}

# run gvim with stdin as file.
vimpager(){
    local tmp=$(mktemp)
    cat - > $tmp
    gvim  -M -R $tmp
    rm $tmp
}

# run gvim with invoke Agit command
agit(){
    gvim -c "Agit --dir=$(pwd)"
}
