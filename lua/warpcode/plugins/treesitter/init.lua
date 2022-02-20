local M = {
    source = 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('warpcode.plugins.treesitter.config'),
    requires = {
        'treesitter_playground',
        -- 'treesitter_rainbow',
    }
}

return M
