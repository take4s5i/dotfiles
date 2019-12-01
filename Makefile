PREFIX ?= ~

.PHONY:install uninstall clean test
clean:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$$(cd $(PREFIX)/ && pwd) clean

install:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$$(cd $(PREFIX)/ && pwd) install

uninstall:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$$(cd $(PREFIX)/ && pwd) uninstall

test:
	rm -rf tmp
	make PREFIX=$$PWD/tmp install
