pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'emmet-ls',
        lspconfig = 'emmet_ls',
    }
end)
