pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'vim-language-server',
        lspconfig = 'vimls',
        validate = function()
            return vim.env.IS_WORK ~= 1
        end
    }
end)
