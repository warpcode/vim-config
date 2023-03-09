ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
EXECUTABLES = curl tar npm php nvim
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

install-nvim: link-nvim update-nvim

update-nvim:
	nvim --headless -V2 -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

test-nvim:
	nvim --headless -c "PlenaryBustedDirectory tests/"

link-nvim: clean-nvim
	test -h ~/.config/nvim/pack/warpcode/opt/ || mkdir -p ~/.config/nvim/pack/warpcode/opt
	test -h ~/.config/nvim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.config/nvim/pack/warpcode/opt/vim-config
	test -h ~/.config/nvim/pack/packer/start/packer.nvim || git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.config/nvim/pack/packer/start/packer.nvim
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/init.vim" ~/.config/nvim/init.vim

clean-nvim:
	rm -rf ~/.cache/nvim
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
