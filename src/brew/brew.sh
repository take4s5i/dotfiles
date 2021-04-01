function add_tap(){
  echo brew tap $1
  if (brew tap | grep -F "$1") ; then
    :
  else
    brew tap $1
  fi
}

function add_install(){
  echo brew install $1
  if (brew list | grep -F "$1") ; then
    :
  else
    brew install $1
  fi
}


add_tap fluxcd/tap
add_tap versent/taps
add_tap weaveworks/tap
add_tap wez/wezterm

brew update

add_install aws-iam-authenticator
add_install awscli
add_install deno
add_install eksctl
add_install flux
add_install freetype
add_install jq
add_install jsonnet
add_install kind
add_install kustomize
add_install minikube
add_install moreutils
add_install skaffold
add_install tmux
add_install watch
add_install wezterm
add_install yarn
add_install git
add_install vim

true
