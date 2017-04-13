

help:
	@echo 'makae install	他のインストールに必要なパッケージを入れる'

install:
	@if [ $$(uname) == "Darwin" ] ; then \
		make brew ; \
	elif [ -f /usr/bin/yum ] ; then \
		make yum ; \
	fi

yum:
	LANG=C sudo yum groupinstall "Development Tools"
	sudo yum install -y epel-release
#git deps
	sudo yum install -y \
		libcurl \
		libcurl-devel \
		openssl \
		openssl-devel \
		expat-devel \
		perl-ExtUtils-MakeMaker \
		gettext-devel \
		asciidoc \
		xmlto \
		docbook-utils \
		docbook2X
	sudo ln -sf /usr/bin/{db2x_docbook2texi,docbook2x-texi}
# vim deps
	sudo yum install -y ncurses ncurses-devel

brew:
	brew install autoconf
	brew install gettext
