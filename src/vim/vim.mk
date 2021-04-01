CONFIGURE_TARGETS += vim

VIM_PKG_ROOT := $(PREFIX)/.vim/pack/dotfiles

.PHONY: vim vim-test

vim:
	ln -sf $(SRC)/vim/.vimrc $(PREFIX)/.vimrc
	mkdir -p $(VIM_PKG_ROOT)/start
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/sheerun/vim-polyglot
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/thinca/vim-quickrun
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/nanotech/jellybeans.vim
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/mattn/emmet-vim
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/itchyny/lightline.vim
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/vim-jp/vimdoc-ja
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/lambdalisue/vim-unified-diff
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/w0rp/ale
	$(SRC)/vim/addpack.sh $(VIM_PKG_ROOT)/start github.com/neoclide/coc.nvim

vim-test:
	test -r $(PREFIX)/.vimrc
