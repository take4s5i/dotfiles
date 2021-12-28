CONFIGURE_TARGETS += fish
TEST_TARGETS += fish-test
FISH_HOME=~/.config/fish/

.PHONY: fish fish-test

fish:
	rm -f $(FISH_HOME)/config.fish
	ln -sf $(SRC)/fish/config.fish $(FISH_HOME)/config.fish
	fish -l $(SRC)/fish/init.fish

fish-test:
	test -r $(FISH_HOME)/config.fish
