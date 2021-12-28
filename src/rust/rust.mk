INSTALL_TARGETS += rust-install
CONFIGURE_TARGETS += rust
TEST_TARGETS += rust-test

.PHONY: rust-install rust-test

rust-install:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rust:
	bash $(SRC)/rust/init.sh

rust-test:
	rustup --version
