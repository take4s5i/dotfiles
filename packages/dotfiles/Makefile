PREFIX ?= ~

.PHONY:install uninstall clean

clean:
	rm -rf $(WORK)

install:
	install -d $(PREFIX)
	ls -1A files | xargs -I{} ln -sf $$PWD/files/{} $(PREFIX)/{}

uninstall:
	ls -1A files | xargs -I{} unlink -f $$PWD/files/{} $(PREFIX)/{}
