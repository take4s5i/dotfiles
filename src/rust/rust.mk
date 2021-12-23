INSTALL_TARGETS += rust-install
TEST_TARGETS += rust-test

.PHONY: rust-install rust-test

rust-install:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh /dev/stdin -y

rust-test:
	rustup --version
