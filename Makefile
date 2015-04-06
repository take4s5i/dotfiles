
DOTFILE = .gitconfig .bash_profile .vimrc .gvimrc
SSHCONFIG = ~/.ssh/config

usage:
	@echo "make usage	# show this help"
	@echo "make distribute DEST=user@host	# distribute dotfiles to other host"

distribute:
	@echo "send files ($(DOTFILE)) to $(DEST)"
	scp -F $(SSHCONFIG) $(DOTFILE) $(DEST):~/

