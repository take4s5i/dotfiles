
.PHONY:install
install:
	@cd packages/dotfiles && make install
	@cd packages/volt && make install
	@cd packages/bin && make install
