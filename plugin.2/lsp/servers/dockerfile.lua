pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'dockerfile-language-server',
        lspconfig = 'dockerls',
    }
end)
