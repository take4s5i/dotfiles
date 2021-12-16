CONFIGURE_TARGETS += starship
TEST_TARGETS += starship-test

.PHONY: starship starship-test

starship:
	ln -sf $(SRC)/starship/starship.toml ~/.config/starship.toml

starship-test:
	test -r ~/.config/starship.toml
