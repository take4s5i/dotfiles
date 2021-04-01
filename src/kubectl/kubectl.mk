INSTALL_TARGETS += kubectl-install
TEST_TARGETS += kubectl-test
CLEAN_TARGETS += kubectl-clean

.PHONY: kubectl-install kubectl-test kubectl-clean

$(CACHE)/kubectl:
	curl -Lo $(CACHE)/kubectl "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"

kubectl-install: $(CACHE)/kubectl
	install -m 755 $(CACHE)/kubectl $(BIN)

kubectl-clean:
	rm -f $(CACHE)/kubectl

kubectl-test:
	$(BIN)/kubectl version --client

