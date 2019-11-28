VERSION=v1.10.0
SYS="$$(uname | tr '[:upper:]' '[:lower:]')"
ARCH=amd64
WORK=work
PREFIX ?= ~
.PHONY:install uninstall clean

clean:
	rm -rf $(WORK)

install:
	mkdir -p $(WORK)
	curl -L -o $(WORK)/kubectl https://storage.googleapis.com/kubernetes-release/release/$(VERSION)/bin/$(SYS)/$(ARCH)/kubectl
	install -d $(PREFIX)/bin
	install -m 755 $(WORK)/kubectl $(PREFIX)/bin/kubectl

uninstall:
	rm -f $(PREFIX)/bin/kubectl
