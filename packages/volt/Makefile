
VERSION=v0.3.5a
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386
WORK=work
PREFIX ?= ~

.PHONY:install uninstall clean

clean:
	rm -rf $(WORK)

install:
	mkdir -p $(WORK)
	curl -L -o $(WORK)/volt "https://github.com/vim-volt/volt/releases/download/$(VERSION)/volt-$(VERSION)-$(SYS)-$(ARCH)"
	install -d $(PREFIX)/bin
	install -m 755 $(WORK)/volt $(PREFIX)/bin/volt
	ln -sf $$PWD/files $(PREFIX)/volt

uninstall:
	rm -f $(PREFIX)/bin/volt
	unlink -f $(PREFIX)/volt
