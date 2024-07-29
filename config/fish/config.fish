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
    set -x EDITOR "nvim"
    set -x LESS "-iMRSX --shift 5"
    set -x LESSCHARSET utf-8
    set -x PLATFORM (uname)
    set -x N_PREFIX (echo ~/)
    set -x TERM screen-256color

    # alias
    alias g='git'
    alias d='docker'
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

    # npm global install
    function ngi
        /usr/local/bin/npm install --location=global $argv
    end

    # npm global uninstall
    function ngu
        /usr/local/bin/npm uninstall --location=global $argv
    end

    # pnpm run
    function nr
        pnpm run $argv
    end

    function t
        set -x TASK_OUTPUT_EVAL "$HOME/.config/taskfile.output.fish"
        rm -f $TASK_OUTPUT_EVAL
        task -t ~/.config/taskfile.yaml $argv

        if test -f $TASK_OUTPUT_EVAL
            source $TASK_OUTPUT_EVAL
        end
    end
end

