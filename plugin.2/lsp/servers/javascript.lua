pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'typescript-language-server',
        lspconfig = 'tsserver',
    }
end)
