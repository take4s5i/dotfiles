
DOTFILE = .gitconfig .bash_profile .vimrc .gvimrc .tmux.conf .gitignore_global .inputrc

help:
	@echo "make help	# show this help"
	@echo "make init	# リポジトリの初期化用。最初の1回だけ実行する"
	@echo "make clean	# remove dotfiles on home directory"
	@echo "make deploy	# create symbolic link to dotfiles on home directory"
	@echo "make install	# 開発ツール一式をインストールする"

.PHONY:init
init:
	git config --local user.name take4s5i
	git config --local user.email take4s5i.0000@gmail.com

.PHONY:clean
clean:
	cd ~/ ; rm -f $(DOTFILE)

.PHONY:delpy
deploy: clean
	echo "$(DOTFILE)" | tr ' ' "\\n" | xargs -I {} ln -s $$(pwd)/{} ~/{}

.PHONY:install
install:
	@sudo echo 'start'
	@export DOTFILES_HOME=$$(git rev-parse --show-toplevel) ;\
	  for target in $$($${DOTFILES_HOME}/init/install-order.sh); do \
		  echo installing $${target} ;\
		  cd $${DOTFILES_HOME}/init/$${target} && make install 2>&1 > install.log;\
	  done
