VERSION=v2.19.2
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=386
WORK=work
PREFIX ?= ~

.PHONY:install uninstall clean

clean:
	rm -rf $(WORK)

install:
	mkdir -p $(WORK)
	curl -L -o $(WORK)/direnv "https://github.com/direnv/direnv/releases/download/$(VERSION)/direnv.$(SYS)-$(ARCH)"
	install -d $(PREFIX)/bin
	install -m 755 $(WORK)/direnv $(PREFIX)/bin/direnv

uninstall:
	rm -f $(PREFIX)/bin/direnv

