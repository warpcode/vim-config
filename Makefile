ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

install-nvim: link-nvim update-nvim

update-nvim:
	nvim --headless -V2 -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

install-vim: link-vim
	# vim -c "quitall"
	vim

test-nvim:
	nvim --headless -c "PlenaryBustedDirectory tests/"

link-nvim: clean-nvim
	test -h ~/.config/nvim/pack/warpcode/opt/ || mkdir -p ~/.config/nvim/pack/warpcode/opt
	test -h ~/.config/nvim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.config/nvim/pack/warpcode/opt/
	test -h ~/.config/nvim/pack/packer/start/packer.nvim || git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.config/nvim/pack/packer/start/packer.nvim
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/vimrc" ~/.config/nvim/init.vim

link-vim:
	test -h ~/.vim/pack/warpcode/opt/ || mkdir -p ~/.vim/pack/warpcode/opt
	test -h ~/.vim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.vim/pack/warpcode/opt/vim-config
	test -h ~/.vimrc || ln -s "$(ROOT_DIR)/vimrc" ~/.vimrc

clean-nvim:
	rm -rf ~/.cache/nvim
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim

clean-vim:
	rm -rf ~/.vimrc
	rm -rf ~/.vim

update-composer:
	wget https://getcomposer.org/download/latest-stable/composer.phar -O bin/composer.phar -q
