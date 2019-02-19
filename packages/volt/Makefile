
VERSION=v0.3.5a
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386

bootstrap:
	@make download
	@touch bootstrap

.PHONY:download
download:
	@mkdir -p tmp
	@curl -L -o tmp/volt "https://github.com/vim-volt/volt/releases/download/$(VERSION)/volt-$(VERSION)-$(SYS)-$(ARCH)"
	@chmod 755 tmp/volt

install:
	@mkdir -p ~/bin
	@cp -f tmp/volt ~/bin
	@unlink ~/volt
	@ln -sf $$PWD/files ~/volt
	@~/bin/volt build
	@touch install
