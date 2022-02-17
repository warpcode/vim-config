local lsp_signature = require('lsp_signature')
local keymaps = require('warpcode.lsp.keymaps')
local M = {}

M.common = function (client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    keymaps.common(client, bufnr)

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
          " hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
          " hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
          " hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
          augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]], false)
    end

    -- Initialise plugins
    lsp_signature.on_attach(client)
end

return M
