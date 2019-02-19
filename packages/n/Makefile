
bootstrap:
	@make clone
	@touch bootstrap

.PHONY:clone
clone:
	@test -d src || git clone https://github.com/tj/n src

install:
	@cd src && PREFIX=~/ make install
	@touch install
