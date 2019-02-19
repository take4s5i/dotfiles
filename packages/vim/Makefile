
bootstrap:
	@make compile
	@touch bootstrap

.PHONY:compile
compile:
	@test -d src || git clone https://github.com/vim/vim src
	@cd src/src && \
		./configure --with-features=huge && \
		make

install:
	@cd src/src && sudo make install
	@touch install
