local M = {
    source = 'mfussenegger/nvim-dap',
    config = function()
        require('warpcode.plugins.nvim-dap.config').run()
    end
}

return M
