
DOTFILE = .gitconfig .bash_profile .vimrc .gvimrc .tmux.conf
SSHCONFIG = ~/.ssh/config

usage:
	@echo "make usage	# show this help"
	@echo "make clean	# remove dotfiles on home directory"
	@echo "make deploy	# create symbolic link to dotfiles on home directory"
	@echo "make distribute DEST=user@host	# distribute dotfiles to other host"

clean:
	cd ~/ ; rm -f $(DOTFILE)

deploy: clean
	echo "$(DOTFILE)" | tr ' ' "\\n" | xargs -I {} ln -s $$(pwd)/{} ~/{}

distribute:
	@echo "send files ($(DOTFILE)) to $(DEST)"
	scp -F $(SSHCONFIG) $(DOTFILE) $(DEST):~/

