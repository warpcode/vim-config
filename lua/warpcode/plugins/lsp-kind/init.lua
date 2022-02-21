local M = {
    source = 'onsails/lspkind-nvim',
    config = function()
        require 'warpcode.plugins.lsp-kind.config'.run()
    end
}

return M
