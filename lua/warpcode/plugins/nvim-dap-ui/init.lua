local M = {
    source = 'rcarriga/nvim-dap-ui',
    config = function()
        print("alert")
        require('warpcode.plugins.nvim-dap-ui.config').run()
    end
}

return M
