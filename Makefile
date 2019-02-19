
.PHONY:install
install:
	./packages/bin/files/dfpkg bootstrap || :
	./packages/bin/files/dfpkg install || :

.PHONY:force-install
force-install:
	./packages/bin/files/dfpkg bootstrap -f || :
	./packages/bin/files/dfpkg install -f || :
