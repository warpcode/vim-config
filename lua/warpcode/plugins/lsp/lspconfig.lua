local M = {}

---Instantly setup an lsp
---@param server string
---@param config table
M.setup_lsp_config_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = M.custom_init,
        on_attach = M.custom_attach,
        capabilities = M.updated_capabilities,
        flags = {
            debounce_text_changes = nil,
        },
    }, config)

    require 'lspconfig'[server].setup(config)
end

---Run some required init tasks
---@param client table
M.custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

---Custom attach procedure
---@param client table
---@param bufnr number
M.custom_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('warpcode.lsp.keymaps').common(client, bufnr)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            group = group
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            callback = function()
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

---Custom capabilities checks
---@return table
M.custom_capabilities = function()
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end

return M
