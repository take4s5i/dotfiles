#!/bin/sh

## use vi mode
set -o vi

## LANG
export LANG=ja_JP.utf8

## path
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/bin

## less
export LESS="-iMRSX --shift 5"

## basics
export PAGER="less"
export EDITOR="vim"

## nodejs
export NODE_PATH=$(npm root -g)

## alias
alias tmux="TERM=xterm-256color tmux"

## alias for git
alias g='git'

## git subcmd alias
for a in $(git config --list | grep -E '^alias\.' | sed -E 's/^alias\.([^=]+)=.+$/\1/'); do
  alias "g${a}=git ${a}"
done

## prompt
git-info() {
    git rev-parse HEAD > /dev/null 2>&1 || return 1

    local BRANCH=$(git rev-parse --abbrev-ref HEAD)
#    local STAT=$(git status -s | cut -c1 |grep -v "!" |tr " MADRCU\?" "\@\*\+\-RCU\?" | uniq -c | tr -d "\n")
    echo -n "[${BRANCH}]"

}
export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[1;34m\]$(git-info)\[\033[00m\]\n\$ '
#export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\]\[\033[00m\]\n\$ '

## function 
test -r ~/.bash_profile.local && source ~/.bash_profile.local


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/admin/.sdkman"
[[ -s "/home/admin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/admin/.sdkman/bin/sdkman-init.sh"
