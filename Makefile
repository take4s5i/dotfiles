PREFIX ?= ~

.PHONY:install uninstall clean test
clean:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$(PREFIX) clean

install:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$(PREFIX) install

uninstall:
	ls -1 packages | xargs -I {} make -C packages/{} PREFIX=$(PREFIX) uninstall

test:
	rm -rf tmp
	make PREFIX=$$PWD/tmp install
