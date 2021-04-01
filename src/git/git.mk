CONFIGURE_TARGETS +=git
TEST_TARGETS += git-test

.PHONY: git git-test
git:
	ln -sf $(SRC)/git/.gitconfig $(PREFIX)/.gitconfig
	ln -sf $(SRC)/git/.gitignore $(PREFIX)/.gitignore

git-test:
	test -r $(PREFIX)/.gitconfig
	test -r $(PREFIX)/.gitignore
