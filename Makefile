ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
EXECUTABLES = curl tar npm php nvim
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))


install: update-node-modules update-php-modules link update

update:
	nvim --headless -V2 -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

update-composer-bin:
	wget https://getcomposer.org/download/latest-stable/composer.phar -O "$(ROOT_DIR)/bin/composer" -q
	chmod +x "$(ROOT_DIR)/bin/composer"

update-node-modules:
	[ -f package-lock.json ] && npm update || true
	[ -f package-lock.json ] && npm ci || npm i

update-php-modules:
	[ -f composer.lock ] && ./bin/composer update || ./bin/composer install

test:
	nvim --headless -c "PlenaryBustedDirectory tests/"

link: clean
	test -h ~/.config/nvim/pack/warpcode/opt/ || mkdir -p ~/.config/nvim/pack/warpcode/opt
	test -h ~/.config/nvim/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" ~/.config/nvim/pack/warpcode/opt/vim-config
	test -h ~/.config/nvim/pack/packer/start/packer.nvim || git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.config/nvim/pack/packer/start/packer.nvim
	test -h ~/.config/nvim/init.vim || ln -s "$(ROOT_DIR)/init.vim" ~/.config/nvim/init.vim

clean:
	rm -rf ~/.cache/nvim
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
