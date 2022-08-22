local keymaps = require('warpcode.lsp.keymaps')
local M = {}

M.common = function (client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    keymaps.common(client, bufnr)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then

        local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function ()
                vim.lsp.buf.document_highlight()
            end,
            group = group
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            callback = function ()
                vim.lsp.buf.clear_references()
            end,
            group = group
        })

        vim.api.nvim_exec([[
            " hi LspReferenceRead cterm=bold ctermbg=239 guibg=#504945
            " hi LspReferenceText cterm=bold ctermbg=239 guibg=#504945
            " hi LspReferenceWrite cterm=bold ctermbg=243 guibg=#7c6f64
        ]], false)
    end
end

return M
