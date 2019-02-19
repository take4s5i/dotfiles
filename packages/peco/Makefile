VERSION=v0.5.3
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386



bootstrap:
	@make download
	@touch bootstrap

.PHONY:download
download:
	@mkdir -p tmp
	@curl -L -o tmp/peco.zip "https://github.com/peco/peco/releases/download/$(VERSION)/peco_$(SYS)_$(ARCH).zip"
	@cd tmp && unzip peco.zip && cp peco_$(SYS)_$(ARCH)/peco ./
	@chmod 755 tmp/peco

install:
	@mkdir -p ~/bin
	@cp -f tmp/peco ~/bin
	@touch install
