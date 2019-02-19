
VERSION=v2.19.2
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386

bootstrap:
	@make download
	@touch bootstrap

.PHONY:download
download:
	@mkdir -p tmp
	@curl -L -o tmp/dirnev "https://github.com/direnv/direnv/releases/download/$(VERSION)/direnv.$(SYS)-$(ARCH)"
	@chmod 755 tmp/dirnev

install:
	@mkdir -p ~/bin
	@cp -f tmp/dirnev ~/bin
	@touch install
