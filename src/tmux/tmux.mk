CONFIGURE_TARGETS += tmux
TEST_TARGETS += tmux-test

.PHONY: tmux tmux-test

tmux:
	ln -sf $(SRC)/tmux/.tmux.conf $(PREFIX)/.tmux.conf

tmux-test:
	test -r $(PREFIX)/.tmux.conf
