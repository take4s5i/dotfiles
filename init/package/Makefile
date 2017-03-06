

help:
	@echo 'makae install	他のインストールに必要なパッケージを入れる'

install:
	@if [ $$(uname) == "Darwin" ] ; then \
		make brew ; \
	fi

yum:
	@echo 'yumでパッケージをインストールするときに使う'

brew:
	brew install autoconf
	brew install gettext
