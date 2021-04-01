CONFIGURE_TARGETS += hyper
TEST_TARGETS += hyper-test

.PHONY: hyper hyper-test

hyper:
	ln -sf $(SRC)/hyper/.hyper.js $(PREFIX)/.hyper.js

hyper-test:
	test -r $(PREFIX)/.hyper.js
