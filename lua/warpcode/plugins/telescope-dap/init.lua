local M = {
    source = 'nvim-telescope/telescope-dap.nvim',
    config = function()
        require('warpcode.plugins.telescope-dap.config').run()
    end
}

return M
