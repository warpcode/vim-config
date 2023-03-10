local M = {
    source = 'williamboman/mason.nvim',
    config = function()
        require 'warpcode.plugins.mason.config'.run()
    end,
    requires = {
        {'williamboman/mason-lspconfig.nvim'},
    }
}

return M
