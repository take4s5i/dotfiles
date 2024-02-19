#!/bin/bash

if [ "$1" == "edit" ]; then
	cd ~/.dotfiles
	${EDITOR:-nvim} ./
	exit $?
fi

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

function git_clone() {
	if [ -d "$2" ]; then
		if [ "$3" != "" ]; then
			(
				cd $2 &&
					git fetch origin
				git switch $3
				git reset --hard
			)
		else
			(cd $2 &&
				git reset --hard &&
				git pull origin)
		fi
	else
		if [ "$3" != "" ]; then
			git clone -b "$3" "$1" "$2"
		else
			git clone "$1" "$2"
		fi
	fi

	if [ "$4" != "" ]; then
		(cd "$2" && eval "$4")
	fi
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
mkdir -p ~/.config/fish
ln -sf $DOTFILES_HOME/config/fish/config.fish ~/.config/fish/config.fish
fish -l $DOTFILES_HOME/init.fish
ln -sf $(type -p fish) ~/bin/fish # for tmux.conf

# git
ln -sf $DOTFILES_HOME/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_HOME/.gitignore ~/.gitignore

# bash
ln -sf $DOTFILES_HOME/.bash_profile ~/.bash_profile
ln -sf $DOTFILES_HOME/.inputrc ~/.inputrc

# peco
if [ ! -L ~/.config/peco ]; then
	rm -rf ~/.config/peco
	ln -sf $DOTFILES_HOME/config/peco ~/.config/peco
fi

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
cargo install cargo-binstall
cargo binstall -y cargo-expand cargo-watch
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
	corepack disable
	hash -r
fi

if [ -x /usr/local/bin/yarn ]; then
	ln -s /usr/local/bin/yarn ~/bin/yarnv1
fi

# volta
# https://volta.sh/
if not has volta; then
	curl https://get.volta.sh | bash -s -- --skip-setup
	hash -r
fi

# sops
# see: https://github.com/getsops/sops
SOPS_VERIONS=v3.8.1
curl -Lo ~/bin/sops https://github.com/getsops/sops/releases/download/$SOPS_VERIONS/sops-$SOPS_VERIONS.darwin.amd64
chmod 755 ~/bin/sops

# pipx
pipx install aws-sso-util

# php
## pecl
pecl install xdebug

# starship
ln -sf $DOTFILES_HOME/config/starship.toml ~/.config/starship.toml

# tmux
ln -sf $DOTFILES_HOME/.tmux.conf ~/.tmux.conf
git_clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim
mkdir -p ~/.vim
ln -sf $DOTFILES_HOME/coc-settings.json ~/.vim/coc-settings.json
VIM_PACK=~/.vim/pack/dotfiles/start
function vimpack() {
	local vpdir="$VIM_PACK/$(basename $1)"
	git_clone "https://$1.git" "$vpdir" "$2" "$3"

}
ln -sf $DOTFILES_HOME/.vimrc ~/.vimrc
vimpack github.com/sheerun/vim-polyglot
vimpack github.com/thinca/vim-quickrun
vimpack github.com/nanotech/jellybeans.vim
vimpack github.com/mattn/emmet-vim
vimpack github.com/itchyny/lightline.vim
vimpack github.com/vim-jp/vimdoc-ja
vimpack github.com/lambdalisue/vim-unified-diff
vimpack github.com/neoclide/coc.nvim release "pwd"
vimpack github.com/ruanyl/vim-gh-line
vimpack github.com/wuelnerdotexe/vim-astro
rm -rf $VIM_PACK/ale

# nvim
mkdir -p ~/.config/nvim
ln -sf $DOTFILES_HOME/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf $DOTFILES_HOME/config/nvim/init.vim ~/.config/nvim/init.vim
NVIM_PACK=~/.config/nvim/after/pack/dotfiles/start
function nvimpack() {
	local vpdir="$NVIM_PACK/$(basename $1)"
	git_clone "https://$1.git" "$vpdir" "$2" "$3"

}
nvimpack github.com/sheerun/vim-polyglot
nvimpack github.com/thinca/vim-quickrun
nvimpack github.com/nanotech/jellybeans.vim
nvimpack github.com/mattn/emmet-vim
nvimpack github.com/itchyny/lightline.vim
nvimpack github.com/vim-jp/vimdoc-ja
nvimpack github.com/lambdalisue/vim-unified-diff
nvimpack github.com/neoclide/coc.nvim release "pwd"
nvimpack github.com/ruanyl/vim-gh-line
nvimpack github.com/wuelnerdotexe/vim-astro
nvim -c 'CocUpdateSync | q' --headless

# aws-cli-cognito
ln -sf $DOTFILES_HOME/aws-cli-cognito.sh ~/bin/aws-cli-cognito

# tflint-language-server
ln -sf $DOTFILES_HOME/tflint-language-server ~/bin/tflint-language-server
