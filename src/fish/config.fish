function has
  type $argv[1] > /dev/null 2>&1
  return $status
end

function here_is
  test "(uname)" = $argv[1]
  return $status
end

function dotfiles
    switch $argv[1]
        case "edit"
            $EDITOR ~/.dotfiles/src/$argv[2]/
        case "run"
            cd ~/.dotfiles
            make $argv[2]
        case '*'
        echo unknown sub-command $argv[1]
    end
    return $status
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    # vi key bindings
    fish_vi_key_bindings

    # env variables
    set LANG "ja_JP.utf8"
    set PATH ~/bin /usr/local/bin $PATH
    set PAGER "less"
    set AWS_PAGER ""
    set EDITOR "vim"
    set LESS "-iMRSX --shift 5"
    set LESSCHARSET utf-8
    set PLATFORM (uname)
    set N_PREFIX (cd ~/ && pwd)

    # alias
    alias tmux="TERM=xterm-256color tmux"
    alias tsw="TERM=xterm-256color tmux split-window"
    alias tnw="TERM=xterm-256color tmux new-window"
    alias g='git'
    alias d='docker'
    alias dcom='docker-compose'
    alias vim='vim -p'
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

    # gvm
    if test -r ~/.gvm/scripts/gvm
        function gvm
          bass source ~/.gvm/scripts/gvm ';' gvm $argv
        end
    end
end
