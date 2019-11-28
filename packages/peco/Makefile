VERSION=v0.5.3
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386
WORK=work
PREFIX ?= ~
.PHONY:install uninstall clean

clean:
	rm -rf $(WORK)

install:
	mkdir -p $(WORK)
	curl -L -o $(WORK)/peco.zip "https://github.com/peco/peco/releases/download/$(VERSION)/peco_$(SYS)_$(ARCH).zip"
	cd $(WORK) && unzip peco.zip && cp peco_$(SYS)_$(ARCH)/peco ./
	install -d $(PREFIX)/bin
	install -m 755 $(WORK)/peco $(PREFIX)/bin/peco

uninstall:
	rm -f $(PREFIX)/bin/peco
