#!/bin/sh

set -e

git clone https://github.com/take4s5i/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
