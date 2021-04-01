export PATH = $(shell pwd)/bin:$(shell printenv PATH)

BASE_DIR := $(shell pwd)
SRC := $(BASE_DIR)/src
TMP := $(BASE_DIR)/.tmp
CACHE := $(BASE_DIR)/.cache

PREFIX := $(HOME)
BIN := $(PREFIX)/bin
CONF := $(PREFIX)/.config/dotfiles

CONFIGURE_TARGETS :=
INSTALL_TARGETS :=
UNINSTALL_TARGETS :=
TEST_TARGETS :=
CLEAN_TARGETS :=

.PHONY: all
all: install configure test

-include src/*/*.mk


.PHONY: before
before:
	mkdir -p $(TMP)
	mkdir -p $(CACHE)
	mkdir -p $(BIN)
	mkdir -p $(CONF)

.PHONY: configure
configure: before $(CONFIGURE_TARGETS)

.PHONY: install
install: before $(INSTALL_TARGETS)

.PHONY: uninstall
uninstall: $(UNINSTALL_TARGETS)

.PHONY: clean
clean: $(CLEAN_TARGETS)

.PHONY: test
test: $(TEST_TARGETS)

.PHONY: list
list:
	@echo $(CONFIGURE_TARGETS) $(INSTALL_TARGETS) $(UNINSTALL_TARGETS) $(CLEAN_TARGETS) $(TEST_TARGETS) | tr ' ' '\n' | sort
