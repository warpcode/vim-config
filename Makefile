VIM_BIN:=$(shell command -v vim 2> /dev/null)
NVIM_BIN:=$(shell command -v nvim 2> /dev/null)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
IMAGE_NAME:=warpcode/nvim:latest
IMAGE_RUN_NAME:=warpcode-nvim-test

install:
ifdef NVIM_BIN
	test -d ~/.config/nvim/ || mkdir -p ~/.config/nvim/
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/.vimrc" ~/.config/nvim/init.vim
	nvim --headless +PlugInstall +qall
else
	@echo "Neovim is not installed. Skipping"
endif
ifdef VIM_BIN
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/.vimrc" ~/.vimrc
	vim +PlugInstall +qall
else
	@echo "Vim is not installed. Skipping"
endif

test: test-build test-run

test-build:
	docker build . -t $(IMAGE_NAME)

test-run:
	docker run --name $(IMAGE_RUN_NAME) --rm -it -e PUID=$(shell id -u) -e PGID=$(shell id -g) -v $(ROOT_DIR):/data $(IMAGE_NAME) /bin/bash

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
