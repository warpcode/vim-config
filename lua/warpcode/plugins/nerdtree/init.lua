local M = {
    source = 'scrooloose/nerdtree',
    requires = {
        {'Xuyuanp/nerdtree-git-plugin'},
        {'jistr/vim-nerdtree-tabs'},
    },
    config = function()
        require 'warpcode.plugins.nerdtree.config'.run()
    end,
}

return M
