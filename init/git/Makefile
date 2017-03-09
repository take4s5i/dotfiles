
src=$${DOTFILES_TMP}/src
version_file=$${DOTFILES_TMP}/version
source_url=https://github.com/git/git.git
prefix=/usr/local
git_tag=v2.12.0

help:
	@echo "make install	gitをインストールする"
	@echo "make clean	キャッシュの削除"

clean:
	@rm $(version_file)

install:
	if [ $$(uname) == "Darwin" ] ; then \
		brew install git ; \
	elif [ ! -r $(version_file) ] ; then \
		make compile ; \
	elif (git --version | diff -q $(version_file) -) ; then \
		echo 'git is installed' ; \
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
		sudo make install prefix=$(prefix) ; \
		git --version > $(version_file)

