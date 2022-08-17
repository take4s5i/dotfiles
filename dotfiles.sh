#!/bin/bash

function not() {
	if $@; then
		return 1
	else
		return 0
	fi
}

function has() {
	type $1 >/dev/null 2>&1
	return $?
}

export PATH=~/bin:$PATH
export DOTFILES_HOME=~/.dotfiles

# dotfiles
if [ ! -d "$DOTFILES_HOME" ]; then
	git clone https://github.com/take4s5i/dotfiles.git $DOTFILES_HOME
	(cd $DOTFILES_HOME && git remote set-url origin git@github.com:take4s5i/dotfiles.git)
fi
mkdir -p ~/bin
ln -sf $DOTFILES_HOME/dotfiles.sh ~/bin/dotfiles

# homebrew
if not has brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ "$(uname)" == "Linux" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ "$(uname)" == "Darwin" ]; then
	if [ -x /opt/homebrew/bin/brew ]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [ -x /usr/local/bin/brew ]; then
		eval "$(/usr/local/bin/brew shellenv)"
	fi
fi

# brew
hash -r
brew update -v
brew upgrade -v
brew bundle --file "$DOTFILES_HOME/Brewfile" -v

# fish
hash -r
rm -f ~/.config/fish/config.fish
ln -sf $DOTFILES_HOME/config.fish ~/.config/fish/config.fish
fish -l $DOTFILES_HOME/init.fish
ln -sf $(type -p fish) ~/bin/fish # for tmux.conf

# git
ln -sf $DOTFILES_HOME/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_HOME/.gitignore ~/.gitignore

# bash
ln -sf $DOTFILES_HOME/.bash_profile ~/.bash_profile
ln -sf $DOTFILES_HOME/.inputrc ~/.inputrc

# rustup
hash -r
if not has rustup; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh /dev/stdin -y
else
	rustup update
fi

if [ -r ~/.cargo/env ]; then
	source ~/.cargo/env
fi

# rust
hash -r
cargo install cargo-expand cargo-binstall
cargo binstall --no-confirm cargo-watch
rustup component add clippy rustfmt

# gvm
hash -r
if [ ! -d ~/.gvm ]; then
	curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
fi

# go
hash -r
go install golang.org/x/tools/gopls@latest
go install github.com/mitranim/gow@latest
go install honnef.co/go/tools/cmd/staticcheck@latest

# hyper
ln -sf $DOTFILES_HOME/.hyper.js ~/.hyper.js

# n
# https://github.com/tj/n
if not has n; then
	curl -Lo ~/bin/n https://raw.githubusercontent.com/tj/n/master/bin/n
	chmod 755 ~/bin/n
fi

if has corepack; then
	corepack enable
	hash -r
fi

if has yarn; then
	yarn set version stable --only-if-needed
	hash -r
fi

# starship
ln -sf $DOTFILES_HOME/starship.toml ~/.config/starship.toml

# tmux
ln -sf $DOTFILES_HOME/.tmux.conf ~/.tmux.conf

# vim
VIM_PACK=~/.vim/pack/dotfiles/start
function vimpack() {
	local vpdir="$VIM_PACK/$(basename $1)"
	mkdir -p $VIM_PACK/start

	if [ -d $vpdir ]; then
		(cd $vpdir && git pull origin)
	else
		git clone "https://$1.git" $vpdir
	fi

	if [ "$2" != "" ]; then
		(cd $vpdir && eval "$2")
	fi
}
ln -sf $DOTFILES_HOME/.vimrc ~/.vimrc
vimpack github.com/sheerun/vim-polyglot
vimpack github.com/thinca/vim-quickrun
vimpack github.com/nanotech/jellybeans.vim
vimpack github.com/mattn/emmet-vim
vimpack github.com/itchyny/lightline.vim
vimpack github.com/vim-jp/vimdoc-ja
vimpack github.com/lambdalisue/vim-unified-diff
vimpack github.com/w0rp/ale
vimpack github.com/neoclide/coc.nvim "yarn && yarn prepare"
vimpack github.com/ruanyl/vim-gh-line

# vim coc-settings
mkdir -p ~/.vim
ln -sf $DOTFILES_HOME/coc-settings.json ~/.vim/coc-settings.json
