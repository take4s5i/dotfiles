
src=$${DOTFILES_TMP}/src
source_url=https://github.com/git/git.git
prefix=/usr/local
git_tag=v2.12.0

help:
	@echo "make install	gitをインストールする"

install:
	if [ $$(uname) == "Darwin" ] ; then \
		brew install git ; \
	else \
		make compile ; \
	fi

compile:
	@mkdir -p $${DOTFILES_TMP}
	@if [ -d $(src) ] ; then \
		git fetch origin  ;\
	else \
		git clone $(source_url) $(src) --depth 100 ;\
	fi
	@cd $(src); \
		git checkout $(git_tag) ; \
		(test  && make configure) ; \
		make prefix=$(prefix) all doc info ; \
		sudo make install prefix=$(prefix)

