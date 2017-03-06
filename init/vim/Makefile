
src=$${DOTFILES_TMP}/src
source_url=https://github.com/vim/vim.git
prefix=/usr/local
git_tag=v8.0.0425

help:
	@echo "make install	vimをインストールする"

install:
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
		sudo make install ;

