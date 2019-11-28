WORK=work
PREFIX ?= ~

.PHONY:install uninstall checkout clean

clean:
	rm -rf $(WORK)

checkout:
	mkdir -p $(WORK)
	test -d $(WORK)/src || git clone https://github.com/tj/n $(WORK)/src
	cd $(WORK)/src && git fetch origin && git reset --hard && git checkout origin/master

install:
	make checkout
	cd $(WORK)/src && make PREFIX=$(PREFIX) install

uninstall:
	make checkout
	cd $(WORK)/src && make PREFIX=$(PREFIX) uninstall
