INSTALL_TARGETS += direnv-install
TEST_TARGETS += direnv-test
CLEAN_TARGETS += direnv-clean

.PHONY: direnv-install direnv-test direnv-clean

$(CACHE)/direnv:
	curl -Lo $(CACHE)/direnv https://github.com/direnv/direnv/releases/download/v2.28.0/direnv.darwin-amd64

direnv-install: $(CACHE)/direnv
	install -m 755 $(CACHE)/direnv $(BIN)

direnv-clean:
	rm -f $(CACHE)/direnv

direnv-test:
	$(BIN)/direnv version
