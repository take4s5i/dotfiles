#!/bin/sh

## path
export PATH=$PATH:/c/PROGRA~2/Git/bin
export PATH=$PATH:/c/bin
export PATH=$PATH:~/bin

## alias
alias gvim='HOME=c:\\Users\\tsc start c:\\Users\\tsc\\app\\vim\\gvim.exe '
alias ls='ls -al --color --show-control-chars '

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

gem(){
    cmd "/C gem.bat ${*}"
}

