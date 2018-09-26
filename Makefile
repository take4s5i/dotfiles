
DOTFILE = .gitconfig .bash_profile .vimrc .gvimrc .tmux.conf .gitignore_global .inputrc
DOTFILES_REPO=$$(git rev-parse --show-toplevel)
DOTFILES_HOME=~/.dotfiles.d

export DOTFILES_HOME

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
	mkdir -p ~/.dotfiles.d
	echo "$(DOTFILE)" | tr ' ' "\\n" | xargs -I {} ln -s $$(pwd)/{} ~/{}
	mkdir -p ~/bin
	ls -1 bin | xargs -i ln -s $$(pwd)/bin/{} ~/bin/{}

.PHONY:make-target
make-target:
	@sudo echo 'start'
	@for target in $$(bash $(DOTFILES_REPO)/init/install-order.sh); do \
		  export DOTFILES_TMP=$(DOTFILES_HOME)/init/tmp/$${target} ;\
		  echo $(TARGET) $${target} ;\
		  mkdir -p $(DOTFILES_HOME)/init/log/$${target} ;\
		  cd $(DOTFILES_REPO)/init/$${target} && make $(TARGET) 2>&1 > $(DOTFILES_HOME)/init/log/$${target}/install.log;\
	done

.PHONY:install
install:
	@make make-target TARGET=install

.PHONY:clean-install
clean-install:
	@make make-target TARGET=clean
