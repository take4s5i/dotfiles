#!/bin/sh

## path
export PATH=$PATH:/c/PROGRA~2/Git/bin
export PATH=$PATH:/c/bin
export PATH=$PATH:~/bin

## alias
alias ls='ls --color --show-control-chars'

## alias for git
alias gs='git status -s'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Cred%d%Creset %s %C(green)%an, %ar%Creset"'

## prompt
git-info() {
    git rev-parse HEAD > /dev/null 2>&1 || return 1

    local BRANCH=$(git rev-parse --abbrev-ref HEAD)
#    local STAT=$(git status -s | cut -c1 |grep -v "!" |tr " MADRCU\?" "\@\*\+\-RCU\?" | uniq -c | tr -d "\n")
    echo -n "[${BRANCH}]"

}
export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[1;34m\]$(git-info)\[\033[00m\]\n\$ '

## function 

# opd : [op]en [d]irectory
# open directory with windows explorer
opd(){
    if [ $# -eq 0 ] ; then
        explorer $(pwd -W | tr '/' '\')
    else
        for d in $@ ; do
            explorer "$((cd $d ; pwd -W) | tr '/' '\')"
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

