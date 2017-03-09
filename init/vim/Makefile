
src=$${DOTFILES_TMP}/src
version_file=$${DOTFILES_TMP}/version
source_url=https://github.com/vim/vim.git
prefix=/usr/local
git_tag=v8.0.0425

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

compile:
	@mkdir -p $${DOTFILES_TMP}
	@if [ -d $(src) ] ; then \
		git fetch origin  ;\
	else \
		git clone $(source_url) $(src) --depth 100 ;\
	fi
	@cd $(src) ; \
		git checkout $(git_tag) ; \
		echo $$(pwd) ; \
		./src/configure --with-features=huge --prefix=$(prefix); \
		make ; \
		sudo make install ; \
		vim --version > $(version_file)

