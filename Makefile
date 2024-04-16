ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR:=~/.config/nvim
EXECUTABLES = curl tar npm php nvim zsh pip3
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

install: update-python-packages update-node-modules link

update-node-modules:
	[ -f package-lock.json ] && npm update || true
	[ -f package-lock.json ] && npm ci || npm i

update-python-packages:
	pip3 install -r requirements.txt

test:
	nvim --headless -c "PlenaryBustedDirectory tests/"

link: clean
	test -h $(CONFIG_DIR)/pack/warpcode/opt/ || mkdir -p $(CONFIG_DIR)/pack/warpcode/opt
	test -h $(CONFIG_DIR)/pack/warpcode/opt/vim-config || ln -s "$(ROOT_DIR)" $(CONFIG_DIR)/pack/warpcode/opt/vim-config
	test -h $(CONFIG_DIR)/init.vim || ln -s "$(ROOT_DIR)/init.lua" $(CONFIG_DIR)/init.lua

clean:
	rm -rf ~/.cache/nvim
	rm -rf $(CONFIG_DIR)
	rm -rf ~/.local/share/nvim

