INSTALL_TARGETS += peco-install
TEST_TARGETS += peco-test
CLEAN_TARGETS += peco-clean

.PHONY: peco-install peco-test peco-clean

$(CACHE)/peco:
	curl -Lo $(TMP)/peco.zip "https://github.com/peco/peco/releases/download/v0.5.8/peco_darwin_amd64.zip"
	unzip -f -d $(TMP)/peco $(TMP)/peco.zip
	cp -f $(TMP)/peco/peco_darwin_amd64/peco $(CACHE)/peco

peco-install: $(CACHE)/peco
	install -m 755 $(CACHE)/peco $(BIN)

peco-clean:
	rm -f $(CACHE)/peco

peco-test:
	$(BIN)/peco --version

