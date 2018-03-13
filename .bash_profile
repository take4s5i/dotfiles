#!/bin/sh

## use vi mode
set -o vi

## env variables
export LANG=ja_JP.utf8
export PATH="$PATH:/usr/local/bin:~/bin"
export PAGER="less"
export EDITOR="vim"
export LESS="-iMRSX --shift 5"
export LESSCHARSET=utf-8
export PLATFORM=$(uname)

## alias
alias tmux="TERM=xterm-256color tmux"
alias g='git'
alias d='docker'
alias dcom='docker-compose'
alias vim='vim -p'

ls_color_opt="$(test "$PLATFORM" == "Linux" && echo '--color' || echo '-G')"
alias ls="ls $ls_color_opt"
alias ll="ls $ls_color_opt -la"

## functions
function has(){
  type $1 > /dev/null 2>&1
  return $?
}

## ssh-agent
if has ssh-agent ; then
  ssh_agent_env=~/.ssh/agent_env.sh
  test -r ${ssh_agent_env} && source ${ssh_agent_env}
  if [ -z "${SSH_AGENT_PID}" -o -z "${SSH_AUTH_SOCK}" ] ; then
    eval $(ssh-agent)
    echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" > ${ssh_agent_env}
    echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> ${ssh_agent_env}
  fi
fi

## npm
if has npm ; then 
  export NODE_PATH=$(npm root -g)
  export PATH="$PATH:$(npm config get prefix 2> /dev/null)"
fi

## direnv
if has direnv ; then
  eval $(direnv hook bash)
fi

## git
if has git ; then
  # command string to show current git branch
  git_branch='$(git rev-parse --is-inside-work-tree > /dev/null 2>&1 && echo "[$(git rev-parse --abbrev-ref HEAD)]")'

  # register aliases for shorthand of git sub-command
  for a in $(git config --list | grep -E '^alias\.' | sed -E 's/^alias\.([^=]+)=.+$/\1/'); do
    alias "g${a}=git ${a}"
  done
fi

## prompt
export PS1="\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[1;34m\]${git_branch}\[\033[00m\]\n\$ "

## function 
test -r ~/.bash_profile.local && source ~/.bash_profile.local
