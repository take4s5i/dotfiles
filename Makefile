
DOTFILE = .gitconfig .bash_profile .vimrc .gvimrc .tmux.conf .gitignore_global .inputrc

help:
	@echo "make help	# show this help"
	@echo "make clean	# remove dotfiles on home directory"
	@echo "make deploy	# create symbolic link to dotfiles on home directory"
	@echo "make install	# 開発ツール一式をインストールする"

clean:
	cd ~/ ; rm -f $(DOTFILE)

deploy: clean
	echo "$(DOTFILE)" | tr ' ' "\\n" | xargs -I {} ln -s $$(pwd)/{} ~/{}

install:
	@sudo echo 'start'
	@export DOTFILES_HOME=$$(git rev-parse --show-toplevel) ;\
	  for target in $$($${DOTFILES_HOME}/init/install-order.sh); do \
		  echo installing $${target} ;\
		  cd $${DOTFILES_HOME}/init/$${target} && make install 2>&1 > install.log;\
	  done
