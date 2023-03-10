ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
EXECUTABLES = curl tar npm php nvim zsh
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

# OS detection
ifeq ($(OS),Windows_NT)
	UNAME_S := $(error Windows not yet supported)
else
	UNAME_S := $(shell uname -s)
	UNAME_S_LOWER := $(shell uname -s | tr '[:upper:]' '[:lower:]')
	UNAME_P := $(shell uname -p)

	ifeq ($(UNAME_S),Linux)
		ifeq ($(UNAME_P),x86_64)
			ARCH_BIN = x64
		else
			ARCH_BIN := $(error "Unsupported architecture $(UNAME_P) for $(UNAME_S)")
		endif
    endif
	ifeq ($(UNAME_S),Darwin)
		ifneq ($(filter arm%,$(UNAME_P)),)
			ARCH_BIN = arm64
		else
			ARCH_BIN := $(error "Unsupported architecture $(UNAME_P) for $(UNAME_S)")
		endif
    endif
endif

install: update-lua-lsp update-node-modules update-php-modules link update

update:
	nvim --headless -V2 -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

update-composer-bin:
	wget https://getcomposer.org/download/latest-stable/composer.phar -O "$(ROOT_DIR)/bin/composer" -q
	chmod +x "$(ROOT_DIR)/bin/composer"

update-lua-lsp:
	[ -d "vendor/luaLS/lua-language-server" ] && rm -r vendor/luaLS/lua-language-server || true
	mkdir -p vendor/luaLS/lua-language-server

	set -e;\
	BIN_VERSION=$$(curl -s https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/');\
	LINK="https://github.com/LuaLS/lua-language-server/releases/download/$$BIN_VERSION/lua-language-server-$$BIN_VERSION-$(UNAME_S_LOWER)-$(ARCH_BIN).tar.gz";\
	curl -sL $$LINK | tar xvfz - -C vendor/luaLS/lua-language-server/;

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

