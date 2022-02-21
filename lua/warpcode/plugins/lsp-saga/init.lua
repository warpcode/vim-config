local M = {
    source = 'tami5/lspsaga.nvim',
    config = function()
        require('warpcode.plugins.lsp-saga.config').run()
    end
}

return M
