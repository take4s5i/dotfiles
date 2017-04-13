
src=$${DOTFILES_TMP}/src
version_file=$${DOTFILES_TMP}/version
source_url=https://github.com/vim/vim.git
prefix=/usr/local
git_tag=v8.0.0562

help:
	@echo "make install	vimをインストールする"
	@echo "make clean	キャッシュの削除"

clean:
	@rm $(version_file)

install:
	if [ ! -r $(version_file) ] ; then \
		make compile ; \
	elif (vim --version | diff -q $(version_file) -) ; then \
		echo 'vim is installed' ; \
	else \
		make compile ;\
	fi

init:
	@if [ ! -d ~/.vim/bundle/neobundle.vim ] ; then \
		mkdir -p ~/.vim/bundle && \
		git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim ; \
	fi
compile:
	@mkdir -p $${DOTFILES_TMP}
	@if [ -d $(src) ] ; then \
		git fetch origin  ;\
	else \
		git clone $(source_url) $(src) --depth 1000 ;\
	fi
	@cd $(src) && \
		git checkout refs/tags/$(git_tag) && \
		echo $$(pwd) && \
		./configure --with-features=huge --prefix=$(prefix) &&\
		make && \
		sudo make install
	@make init
	@vim --version > $(version_file)

