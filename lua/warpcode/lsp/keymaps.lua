local M = {}

M.common = function(client, bufnr)
    local opts = {noremap = true, silent = true, buffer = bufnr}

    -- Mappings.
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.keymap.set("n", "gD", lbuf.declaration, opts)
    vim.keymap.set("n", "gd", lbuf.definition, opts)
    vim.keymap.set("n", "K", lbuf.hover, opts)
    vim.keymap.set("n", "gi", lbuf.implementation, opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>=", lbuf.formatting_seq_sync, opts)
    elseif client.resolved_capabilities.document_range_formatting then
        vim.keymap.set("n", "<leader>=", lbuf.range_formatting, opts)
    end

    if client.resolved_capabilities.document_range_formatting then
        vim.keymap.set("x", "<leader>=", lbuf.range_formatting, opts)
    end
end

return M
