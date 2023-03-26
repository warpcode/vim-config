pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'bash-language-server',
        lspconfig = 'bashls',
    }
end)
