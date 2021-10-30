ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

IMAGE_NAME:=warpcode/nvim:latest
IMAGE_RUN_NAME:=warpcode-nvim-test

install-nvim: clean-nvim
	test -h ~/.config/nvim || mkdir -p ~/.config/nvim
	test -h ~/.config/nvim || ln -s "$(ROOT_DIR)/vimrc" ~/.config/nvim/init.vim
	nvim --headless +PlugInstall +qall

install-vim: clean-vim
	test -h ~/.vim || mkdir -p ~/.vim
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/vimrc" ~/.vimrc
	vim +PlugInstall +qall

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
