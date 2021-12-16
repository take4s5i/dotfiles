INSTALL_TARGETS += brew-install
TEST_TARGETS += brew-test
CLEAN_TARGETS += brew-clean

.PHONY: brew-install brew-test brew-clean

brew-install:
	type brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file $(SRC)/brew/Brewfile

brew-test:
	brew --version
