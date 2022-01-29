CONFIGURE_TARGETS += go
TEST_TARGETS += go-test

.PHONY: go-test go

go:
	test -d ~/.gvm || (curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash)
	go install golang.org/x/tools/gopls@latest
	go install github.com/mitranim/gow@latest


go-test:
	go version
