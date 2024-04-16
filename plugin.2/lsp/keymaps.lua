local pexec = require 'warpcode.priority-exec'
local events = require 'warpcode.events'
local maps = require "warpcode.keymaps"
local lbuf = vim.lsp.buf

-- Default actions for lsp keymaps
pexec.addCall('lsp.code_action', function() lbuf.code_action() end, 0)
pexec.addCall('lsp.declaration', function() lbuf.declaration() end, 0)
pexec.addCall('lsp.definition', function() lbuf.definition() end, 0)
pexec.addCall('lsp.format', function() lbuf.format() end, 0)
pexec.addCall('lsp.hover', function() lbuf.hover() end, 0)
pexec.addCall('lsp.implementation', function() lbuf.implementation() end, 0)
pexec.addCall('lsp.references', function() lbuf.references() end, 0)
pexec.addCall('lsp.rename', function() lbuf.rename() end, 0)
pexec.addCall('lsp.server_capabilities', function(client) print(vim.inspect(client.server_capabilities)) end, 0)
pexec.addCall('lsp.signature_help', function() lbuf.signature_help() end, 0)
pexec.addCall('lsp.type_definition', function() lbuf.type_definition() end, 0)
pexec.addCall('lsp.add_workspace_folder', function() lbuf.add_workspace_folder() end, 0)
pexec.addCall('lsp.list_workspace_folders', function() lbuf.list_workspace_folders() end, 0)
pexec.addCall('lsp.remove_workspace_folder', function() lbuf.remove_workspace_folder() end, 0)

events.addEventListener('lsp.on_attach', function(_, client, bufnr)
    local opts = maps.extend_default_opt({ buffer = bufnr })

    maps.map_list({
        { { 'n', 'v' }, '<leader>ca', function() pexec.exec('lsp.code_action', client, bufnr) end,             opts },
        { "n",          "gD",         function() pexec.exec('lsp.declaration', client, bufnr) end,             opts },
        { "n",          "gd",         function() pexec.exec('lsp.definition', client, bufnr) end,              opts },
        { { "n", 'x' }, "<leader>=",  function() pexec.exec('lsp.format', client, bufnr) end,                  opts },
        { "n",          "K",          function() pexec.exec('lsp.hover', client, bufnr) end,                   opts },
        { "n",          "gi",         function() pexec.exec('lsp.implementation', client, bufnr) end,          opts },
        { "n",          "gr",         function() pexec.exec('lsp.references', client, bufnr) end,              opts },
        { "n",          "<leader>rn", function() pexec.exec('lsp.rename', client, bufnr) end,                  opts },
        { "n",          "<C-k>",      function() pexec.exec('lsp.signature_help', client, bufnr) end,          opts },
        { 'n',          '<leader>D',  function() pexec.exec('lsp.type_definition', client, bufnr) end,         opts },
        { "n",          "<space>wa",  function() pexec.exec('lsp.add_workspace_folder', client, bufnr) end,    opts },
        { "n",          "<space>wr",  function() pexec.exec('lsp.remove_workspace_folder', client, bufnr) end, opts },
        { "n",          "<space>wl",  function() pexec.exec('lsp.list_workspace_folders', client, bufnr) end,  opts },
        -- { "n", '<leader>lcc', M.default_actions['server_capabilities'](client), opts }
    })
end)
