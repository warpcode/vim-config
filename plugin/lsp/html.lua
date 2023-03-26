pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'html-lsp',
        lspconfig = 'html',
    }
end)
