local M = {
    source = 'rcarriga/nvim-dap-ui',
    config = function()
        require('warpcode.plugins.nvim-dap-ui.config').run()
    end
}

return M
