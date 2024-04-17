local pexec = require 'warpcode.priority-exec'
local maps = require "warpcode.keymaps"

maps.map_list({
    { { 'n', 'v' }, '<leader>ca', function() pexec.exec('lsp.code_action') end,             maps.extend_default_opt({ desc = 'LSP: Code Actions'}) },
    { "n",          "gD",         function() pexec.exec('lsp.declaration') end,             maps.extend_default_opt({ desc = 'LSP: Go to Declaration'}) },
    { "n",          "gd",         function() pexec.exec('lsp.definition') end,              maps.extend_default_opt({ desc = 'LSP: Go to Definition'}) },
    { { "n", 'x' }, "<leader>=",  function() pexec.exec('lsp.format') end,                  maps.extend_default_opt({ desc = 'LSP: Format'}) },
    { "n",          "K",          function() pexec.exec('lsp.hover') end,                   maps.extend_default_opt({ desc = 'LSP: Hover Documentation'}) },
    { "n",          "gi",         function() pexec.exec('lsp.implementation') end,          maps.extend_default_opt({ desc = 'LSP: Go to Implementation'}) },
    { "n",          "gr",         function() pexec.exec('lsp.references') end,              maps.extend_default_opt({ desc = 'LSP: Go to References'}) },
    { "n",          "<leader>rn", function() pexec.exec('lsp.rename') end,                  maps.extend_default_opt({ desc = 'LSP: Rename'}) },
    { "n",          "<C-k>",      function() pexec.exec('lsp.signature_help') end,          maps.extend_default_opt({ desc = 'LSP: Signature Help'}) },
    { 'n',          '<leader>D',  function() pexec.exec('lsp.type_definition') end,         maps.extend_default_opt({ desc = 'LSP: Type Definition'}) },
    { "n",          "<space>wa",  function() pexec.exec('lsp.add_workspace_folder') end,    maps.extend_default_opt({ desc = 'LSP: Add Workspace Folder'}) },
    { "n",          "<space>wr",  function() pexec.exec('lsp.remove_workspace_folder') end, maps.extend_default_opt({ desc = 'LSP: Remove Workspace Folder'}) },
    { "n",          "<space>wl",  function() pexec.exec('lsp.list_workspace_folders') end,  maps.extend_default_opt({ desc = 'LSP: List Workspace folders'}) },
})
