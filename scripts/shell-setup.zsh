WVIM_BASEDIR=$(dirname "${0:A:h}")

# Setup path for wvim
# This allows all our local dependencies to load just for neovim
export PATH="$PATH:${LVIM_BASEDIR}/bin"
export PATH="$PATH:${WVIM_BASEDIR}/node_modules/.bin"
export PATH="$PATH:${WVIM_BASEDIR}/php_modules/bin"
