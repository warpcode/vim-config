local M = {
    source = 'theHamsta/nvim-dap-virtual-text',
    config = function()
        require('warpcode.plugins.nvim-dap-virtual-text.config').run()
    end
}

return M
