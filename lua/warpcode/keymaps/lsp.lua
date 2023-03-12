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
    server_capabilities = function(client)
        return function()
            print(vim.inspect(client.server_capabilities))
        end
    end,
    signature_help = function()
        lbuf.signature_help()
    end,
    type_definition = function()
        lbuf.type_definition()
    end,
    add_workspace_folder = function()
        lbuf.add_workspace_folder()
    end,
    list_workspace_folders = function()
        print(vim.inspect(lbuf.list_workspace_folders()))
    end,
    remove_workspace_folder = function()
        lbuf.remove_workspace_folder()
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
        { { 'n', 'v' }, '<leader>ca', M.default_actions['code_action'],             opts },
        { "n",          "gD",         M.default_actions['declaration'],             opts },
        { "n",          "gd",         M.default_actions['definition'],              opts },
        { { "n", 'x' }, "<leader>=",  M.default_actions['format'],                  opts },
        { "n",          "K",          M.default_actions['hover'],                   opts },
        { "n",          "gi",         M.default_actions['implementation'],          opts },
        { "n",          "gr",         M.default_actions['references'],              opts },
        { "n",          "<leader>rn", M.default_actions['rename'],                  opts },
        { "n",          "<C-k>",      M.default_actions['signature_help'],          opts },
        { 'n',          '<leader>D',  M.default_actions['type_definition'],         opts },
        { "n",          "<space>wa",  M.default_actions['add_workspace_folder'],    opts },
        { "n",          "<space>wr",  M.default_actions['remove_workspace_folder'], opts },
        { "n",          "<space>wl",  M.default_actions['list_workspace_folders'],  opts },
        -- { "n", '<leader>lcc', M.default_actions['server_capabilities'](client), opts }
    })

    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

return M
