INSTALL_TARGETS += brew-install
CONFIGURE_TARGETS += brew
TEST_TARGETS += brew-test

.PHONY: brew-install brew-test brew

brew-install:
	type brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew:
	brew bundle --file $(SRC)/brew/Brewfile -v

brew-test:
	brew --version
