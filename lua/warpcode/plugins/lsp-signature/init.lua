local M = {
    source = 'ray-x/lsp_signature.nvim',
    config = function()
        require('warpcode.plugins.lsp-signature.config').run()
    end
}

return M
