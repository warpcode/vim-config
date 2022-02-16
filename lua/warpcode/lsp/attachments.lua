local lsp_signature = require('lsp_signature')
local keymaps = require('warpcode.lsp.keymaps')
local M = {}

M.common = function (client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    keymaps.common(client, bufnr)

    -- Initialise plugins
    lsp_signature.on_attach(client)
end

return M
