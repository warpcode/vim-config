local M = {}
local lbuf = vim.lsp.buf

M.common = function(client, bufnr)
    local opts = {noremap = true, silent = true, buffer = bufnr}

    -- Mappings.
    vim.keymap.set('n', '<leader>ca', lbuf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', lbuf.range_code_action, opts)

    if client.server_capabilities.declarationProvider then
        vim.keymap.set("n", "gD", lbuf.declaration, opts)
    end

    if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
        vim.keymap.set("n", "gd", lbuf.definition, opts)
    end

    if client.server_capabilities.hoverProvider then
        vim.keymap.set("n", "K", lbuf.hover, opts)
    end

    if client.server_capabilities.implementationProvider then
        vim.keymap.set("n", "gi", lbuf.implementation, opts)
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set("n", "gr", lbuf.references, opts)
    end

    if client.server_capabilities.renameProvider then
        vim.keymap.set("n", "<leader>rn", lbuf.rename, opts)
    end

    -- if client.server_capabilities.signatureHelpProvider then
    --     vim.keymap.set("n", "<C-k>", "<cmd>lua lbuf.signature_help()<CR>", opts)
    -- end

    -- if client.server_capabilities.typeDefinitionProvider then
    --     vim.keymap.set('n', '<leader>D', lbuf.type_definition, opts("Go to type definition"))
    -- end
    --

    -- Formatting options
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>=", lbuf.format, opts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set("n", "<leader>=", lbuf.range_formatting, opts)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set("x", "<leader>=", lbuf.range_formatting, opts)
    end

    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- buf_set_keymap("n", "<space>wa", "<cmd>lua lbuf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua lbuf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(lbuf.list_workspace_folders()))<CR>", opts)


    -- vim.keymap.set('n', '<leader>lc', function()
    --     print(vim.inspect(client.server_capabilities))
    -- end, opts)
end

return M
