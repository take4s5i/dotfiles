#!/bin/sh
function _push_path(){
  if [ -z "$(echo $PATH | tr ':' '\n' | grep -F "$1")" ]; then
    if [ "$2" == "first" ] ; then
      export PATH=$1:$PATH
    else
      export PATH=$PATH:$1
    fi
  fi
}


## use vi mode
set -o vi

## LANG
export LANG=ja_JP.utf8

## path
_push_path /opt/rbenv/bin first
_push_path /usr/local/bin last
_push_path ~/bin last

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

## ssh-agent
ssh_agent_env=~/.ssh/agent_env.sh
test -r ${ssh_agent_env} && source ${ssh_agent_env}
if [ -z "${SSH_AGENT_PID}" -o -z "${SSH_AUTH_SOCK}" ] ; then
  eval $(ssh-agent)
  echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" > ${ssh_agent_env}
  echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> ${ssh_agent_env}
fi

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
