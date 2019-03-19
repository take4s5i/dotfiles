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
alias tsw="TERM=xterm-256color tmux split-window"
alias g='git'
alias d='docker'
alias dcom='docker-compose'
alias vim='vim -p'
alias kc='kubectl'

ls_color_opt="$(test "$PLATFORM" == "Linux" && echo '--color' || echo '-G')"
alias ls="ls $ls_color_opt"
alias ll="ls $ls_color_opt -la"

## functions
function has(){
  type $1 > /dev/null 2>&1
  return $?
}

function kcsw() {
  kc config use-context $(kc config get-contexts -o name | peco)
}

function decorate(){
  # fg
  case $1 in
    black)    printf "\033[30m" ;;
    red)      printf "\033[31m" ;;
    green)    printf "\033[32m" ;;
    yellow)   printf "\033[33m" ;;
    blue)     printf "\033[34m" ;;
    magenda)  printf "\033[35m" ;;
    cyan)     printf "\033[36m" ;;
    white)    printf "\033[37m" ;;
  esac

  # bg
  case $2 in
    black)    printf "\033[40m" ;;
    red)      printf "\033[41m" ;;
    green)    printf "\033[42m" ;;
    yellow)   printf "\033[43m" ;;
    blue)     printf "\033[44m" ;;
    magenda)  printf "\033[45m" ;;
    cyan)     printf "\033[46m" ;;
    white)    printf "\033[47m" ;;
  esac

  cat -

  printf "\033[00m"
}

function show_indicator(){
## git
  if has git ; then
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1 ; then
      if git rev-parse --abbrev-ref HEAD > /dev/null 2>&1 ; then
        printf "[git@$(git rev-parse --abbrev-ref HEAD)] " | decorate cyan
      else
        printf "[git@-] " | decorate cyan
      fi
    fi
  fi

## kubectl
  if has kubectl ; then
    printf "[k8s@$(kubectl config current-context)]" | decorate cyan
  fi
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
  export PATH="$PATH:$(npm config get prefix 2> /dev/null)/bin"
fi

## direnv
if has direnv ; then
  eval $(direnv hook bash)
fi

if has git ; then
  # register aliases for shorthand of git sub-command
  for a in $(git config --list | grep -E '^alias\.' | sed -E 's/^alias\.([^=]+)=.+$/\1/'); do
    alias "g${a}=git ${a}"
  done
fi

## prompt
export PS1='\n\[\033[32m\]\u@\h \[\033[33m\w\033[0m\] $(show_indicator)\n\$ '

## function 
test -r ~/.bash_profile.local && source ~/.bash_profile.local
