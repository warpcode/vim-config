local M = {}
local lbuf = vim.lsp.buf
local maps = require "warpcode.keymaps"

M.default_actions = setmetatable({
    code_action = function()
        lbuf.code_action()
    end,
    declaration = function()
        lbuf.declaration()
    end,
    definition = function()
        lbuf.definition()
    end,
    format = function()
        lbuf.format()
    end,
    hover = function()
        lbuf.hover()
    end,
    implementation = function()
        lbuf.implementation()
    end,
    references = function()
        lbuf.references()
    end,
    rename = function()
        lbuf.rename()
    end,
    signature_help = function()
        lbuf.signature_help()
    end,
    type_definition = function()
        lbuf.type_definition()
    end,
}, {
    __index = function()
        return function()
        end
    end,
})

M.common = function(client, bufnr)
    local opts = maps.extend_default_opt({ buffer = bufnr })

    maps.map_list({
        { 'n', '<leader>ca', M.default_actions['code_action'],    opts },
        { 'v', '<leader>ca', M.default_actions['code_action'],    opts },
        { "n", "gD",         M.default_actions['declaration'],    opts },
        { "n", "gd",         M.default_actions['definition'],     opts },
        { "n", "<leader>=",  M.default_actions['format'],         opts },
        { "x", "<leader>=",  M.default_actions['format'],         opts },
        { "n", "K",          M.default_actions['hover'],          opts },
        { "n", "gi",         M.default_actions['implementation'], opts },
        { "n", "gr",         M.default_actions['references'],     opts },
        { "n", "<leader>rn", M.default_actions['rename'],         opts },
    })


    if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    end

    -- if client.server_capabilities.signatureHelpProvider then
    --     vim.keymap.set("n", "<C-k>", "<cmd>lua lbuf.signature_help()<CR>", opts)
    -- end

    -- if client.server_capabilities.typeDefinitionProvider then
    --     vim.keymap.set('n', '<leader>D', lbuf.type_definition, opts("Go to type definition"))
    -- end
    --

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
