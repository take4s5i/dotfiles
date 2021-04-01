CONFIGURE_TARGETS += bash
TEST_TARGETS += bash-test

.PHONY: bash bash-test

bash:
	mkdir -p $(CONF)/bash
	ln -sf $(SRC)/bash/.bash_profile $(PREFIX)/.bash_profile
	ln -sf $(SRC)/bash/.inputrc $(PREFIX)/.inputrc

bash-test:
	test -r $(PREFIX)/.bash_profile
	test -r $(PREFIX)/.inputrc
