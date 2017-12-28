#!/bin/sh

## use vi mode
set -o vi

## env variables
export LANG=ja_JP.utf8
export PATH="$PATH:/usr/local/bin:~/bin:$(npm config get prefix 2> /dev/null)"
export PAGER="less"
export EDITOR="vim"

## less
export LESS="-iMRSX --shift 5"
export LESSCHARSET=utf-8

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

# direnv
if type direnv > /dev/null 2>&1 ; then
  eval $(direnv hook bash)
fi

## prompt
git_branch=""
if type git > /dev/null 2>&1 ; then
  git_branch='$(git rev-parse --is-inside-work-tree > /dev/null 2>&1 && echo "[$(git rev-parse --abbrev-ref HEAD)]")'
fi

export PS1="\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[1;34m\]${git_branch}\[\033[00m\]\n\$ "

## function 
test -r ~/.bash_profile.local && source ~/.bash_profile.local
