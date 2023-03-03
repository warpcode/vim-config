local M = {
    source = 'hrsh7th/nvim-cmp',
    config = function()
        require 'warpcode.plugins.cmp.config'.run()
    end,
}

return M
