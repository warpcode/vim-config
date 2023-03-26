pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'json-lsp',
        lspconfig = 'jsonls',
    }
end)
