ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

IMAGE_NAME:=warpcode/nvim:latest
IMAGE_RUN_NAME:=warpcode-nvim-test

install-nvim: clean-nvim
	test -h ~/.config || mkdir -p ~/.config
	test -h ~/.config/nvim || ln -s "$(ROOT_DIR)" ~/.config/nvim
	$(NVIM_BIN) --headless +PlugInstall +qall

install-vim: clean-vim
	test -h ~/.vim || ln -s "$(ROOT_DIR)" ~/.vim
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/vimrc" ~/.vimrc
	$(VIM_BIN) +PlugInstall +qall

test: test-build test-run

test-build:
	docker build . -t $(IMAGE_NAME)

test-run:
	docker run --name $(IMAGE_RUN_NAME) --rm -it -e PUID=$(shell id -u) -e PGID=$(shell id -g) -v $(ROOT_DIR):/data $(IMAGE_NAME) /bin/bash

clean-nvim:
	rm -rf ~/.config/nvim

clean-vim:
	rm -rf ~/.vimrc
	rm -rf ~/.vim
