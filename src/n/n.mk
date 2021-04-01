INSTALL_TARGETS += n-install
TEST_TARGETS += n-test
CLEAN_TARGETS += n-clean

.PHONY: n-install n-test n-clean

$(CACHE)/n:
	curl -Lo $(CACHE)/n https://raw.githubusercontent.com/tj/n/master/bin/n

n-install: $(CACHE)/n
	install -m 755 $(CACHE)/n $(BIN)

n-clean:
	rm -f $(CACHE)/n

n-test:
	$(BIN)/n --version

