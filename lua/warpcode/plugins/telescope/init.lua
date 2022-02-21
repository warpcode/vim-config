local M = {
    source = 'nvim-telescope/telescope.nvim',
    config = function()
        require('warpcode.plugins.telescope.config').run()
    end
}

return M
