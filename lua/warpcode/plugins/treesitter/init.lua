local M = {
    source = 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
        require('warpcode.plugins.treesitter.config').run()
    end
}

return M
