ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

IMAGE_NAME:=warpcode/nvim:latest
IMAGE_RUN_NAME:=warpcode-nvim-test

pre-setup:
	npm i
	composer install

install-nvim: clean-nvim pre-setup
	test -h ~/.config/nvim/pack/warpcode/opt/ || mkdir -p ~/.config/nvim/pack/warpcode/opt
	test -h ~/.config/nvim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.config/nvim/pack/warpcode/opt/
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/vimrc" ~/.config/nvim/init.vim
	# nvim --headless -c 'quitall'
	nvim

install-vim: clean-vim pre-setup
	test -h ~/.vim/pack/warpcode/opt/ || mkdir -p ~/.vim/pack/warpcode/opt
	test -h ~/.vim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.vim/pack/warpcode/opt/vim-config
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/vimrc" ~/.vimrc
	# vim -c "quitall"
	vim

test: test-build test-run

test-build:
	docker build . -t $(IMAGE_NAME)

test-run:
	docker run --name $(IMAGE_RUN_NAME) --rm -it -e PUID=$(shell id -u) -e PGID=$(shell id -g) -v $(ROOT_DIR):/data $(IMAGE_NAME) /bin/bash

clean-nvim:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim

clean-vim:
	rm -rf ~/.vimrc
	rm -rf ~/.vim
