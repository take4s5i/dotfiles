function has
  type $argv[1] > /dev/null 2>&1
  return $status
end

function here_is
  test "(uname)" = $argv[1]
  return $status
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    # completions
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); /usr/local/bin/aws_completer | sed \'s/ $//\'; end)'

    # vi key bindings
    fish_vi_key_bindings

    # env variables
    set -x LANG "ja_JP.utf8"
    set -x PATH ~/bin /usr/local/bin $PATH
    set -x PAGER "less"
    set -x AWS_PAGER ""
    set -x EDITOR "vim"
    set -x LESS "-iMRSX --shift 5"
    set -x LESSCHARSET utf-8
    set -x PLATFORM (uname)
    set -x N_PREFIX (cd ~/ && pwd)

    # alias
    alias tmux="TERM=xterm-256color tmux"
    alias tsw="TERM=xterm-256color tmux split-window"
    alias tnw="TERM=xterm-256color tmux new-window"
    alias g='git'
    alias d='docker'
    alias dcom='docker-compose'
    alias kc='kubectl'
    set ls_color_opt "(test "$PLATFORM" = "Linux" && echo '--color' || echo '-G')"
    alias ls="ls $ls_color_opt"
    alias ll="ls $ls_color_opt -la"

    if here_is Linux
        set PATH /home/linuxbrew/.linuxbrew/bin $PATH
    end

    if has npm
      set NODE_PATH (npm root -g)
      set PATH $PATH "(npm config get prefix 2> /dev/null)/bin"
    end

    if has git
      # register aliases for shorthand of git sub-command
      for a in (git config --list | grep -E '^alias\.' | sed -E 's/^alias\.([^=]+)=.+$/\1/')
        alias "g$a=git $a"
      end
    end

    # direnv
    if has direnv
        direnv hook fish | source
    end

    # cargo
    if test -r ~/.cargo/env
        bass source ~/.cargo/env
    end

    # starship
    if has starship
        starship init fish | source
    end

    # go
    if test -r ~/go
        set PATH ~/go/bin $PATH
    end

    # gvm
    if test -r ~/.gvm/scripts/gvm
        function gvm
          bass source ~/.gvm/scripts/gvm ';' gvm $argv
        end
    end

    # asdf
    if test -r /usr/local/opt/asdf/libexec/asdf.fish
        source /usr/local/opt/asdf/libexec/asdf.fish
    end

    # pipx
    if has pipx
        set PATH $PATH ~/.local/bin
    end

    # volta
    set -gx VOLTA_FEATURE_PNPM "true"
    set -gx VOLTA_HOME "$HOME/.volta"
    set -gx PATH "$VOLTA_HOME/bin" $PATH

    # util functions
    function xxx-aws-use-profile
        set -gx AWS_PROFILE "$(aws configure list-profiles | peco --prompt 'select aws profile >')"
    end

    function xxx-aws-list-ec2-instances
	    aws ec2 describe-instances --filter 'Name=instance-state-name,Values=running' --output text --query 'Reservations[].Instances[].[InstanceId, State.Name, InstanceType, PrivateIpAddress, Platform || `Linux`, Tags[?Key == `Name`].Value | [0]]'
    end

    function xxx-aws-list-rds-clusters
	    aws rds describe-db-clusters --output text --query 'DBClusters[].[DBClusterIdentifier, Status, Engine, Port, Endpoint]'
    end

    function xxx-aws-ssh-ec2-instance
        aws ssm start-session --target "$(xxx-aws-list-ec2-instances | peco --prompt 'select ec2 instance >' | cut -f1)" $argv
    end

    function xxx-aws-ecr-login
        set region "$(aws configure get region)"
        set registry_id "$(aws ecr describe-registry --query 'registryId' --output text)"
        aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $registry_id.dkr.ecr.$region.amazonaws.com
    end

    function xxx-aws-port-forward
        if test -z "$argv[1]" -o -z "$argv[2]" -o -z "$argv[3]"
            echo "xxx-aws-port-forward <remote host> <remote port> <local port>"
            return 1
        end
        xxx-aws-ssh-ec2-instance --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters "host=$argv[1],portNumber=$argv[2],localPortNumber=$argv[3]"
    end

    function xxx-aws-port-forward-to-rds-cluster
        if test -z "$argv[1]"
            echo "xxx-aws-port-forward-to-rds-cluster <local port>"
            return 1
        end

        set db_cluster "$(xxx-aws-list-rds-clusters | peco --prompt 'select rds cluster >')"
        set remote_host "$(string split -f5 \t "$db_cluster")"
        set remote_port "$(string split -f4 \t "$db_cluster")"
        xxx-aws-port-forward $remote_host $remote_port $argv[1]
    end

    function xxx-terraform-show-state
        terraform state show "$(terraform state list | peco --prompt 'select terraform resource >')"
    end
end
