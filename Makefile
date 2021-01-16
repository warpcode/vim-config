VIM_BIN:=$(shell command -v vim 2> /dev/null)
NVIM_BIN:=$(shell command -v nvim 2> /dev/null)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

install:
ifdef NVIM_BIN
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/.vimrc" ~/.config/nvim/init.vim
	nvim +PlugInstall +qall
else
	@echo "Neovim is not installed. Skipping"
endif
ifdef VIM_BIN
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/.vimrc" ~/.vimrc
	vim +PlugInstall +qall
else
	@echo "Vim is not installed. Skipping"
endif

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
