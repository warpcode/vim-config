local M = {
    source = 'L3MON4D3/LuaSnip',
    requires = {
        {'rafamadriz/friendly-snippets'},
        {'honza/vim-snippets'},
    },
    config = function()
        require 'warpcode.plugins.snippets.config'.run()
    end,
}

return M
