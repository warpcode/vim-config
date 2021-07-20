# My personal Vim config
Love it or hate it but this is my personal vim config. This is tailor made to me so if you're looking for a fully featured vim config where everything is done for you, try SpaceVim.

## Install
### Install the latest NVIM

This config requires at least neovim 0.50
As of writing this, it's only availbale from the github releases page or the unstable PPA
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt install neovim
```

### Install the latest VIM

This config is used on vim 8.2. The latest version of vim on ubuntu can be installed via the following PPA
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

### Run Make
To install to nvim run
```
make install-nvim
```

To install to vim run
```
make install-vim
```

These commands will remove any old config

### Updating
On the first load, if vim-plug is not installed, the script will auto install it provided curl is installed.
To update use one of the following depending on whether you are using vim or nvim

`nvim +PlugInstall +qall`

or

`vim +PlugInstall +qall`

## Dependencies
These dependencies are for ubuntu based systems as this is what i primarily use

```
build-essential
cmake
python3-dev
exuberant-ctags
silversearcher-ag
php-codesniffer
```
