local M = {
    source = 'hrsh7th/nvim-cmp',
    config = function()
        require 'warpcode.plugins.cmp.config'.run()
    end,
    requires = {
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-calc'},
        {'hrsh7th/cmp-cmdline'},
        {'hrsh7th/cmp-emoji'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'hrsh7th/cmp-omni'},
        {'hrsh7th/cmp-path'},
        {
            'tzachar/cmp-tabnine',
            run = './install.sh',
        },
        {'ray-x/cmp-treesitter'},
    }
}

return M
