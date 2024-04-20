local pexec = require 'warpcode.utils.priority-exec'
local maps = require "warpcode.utils.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('diagnostics.next', function() vim.diagnostic.goto_next() end, 0)
pexec.addCall('diagnostics.prev', function() vim.diagnostic.goto_prev() end, 0)
pexec.addCall('diagnostics.buffer', function() vim.diagnostic.setloclist() end, 0)
pexec.addCall('diagnostics.workspace', function() vim.diagnostic.setqflist() end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "[d",         function() pexec.exec('diagnostics.prev') end,      maps.extend_default_opt({ desc = 'Diagnostics: Previous' }) },
    { "n", "]d",         function() pexec.exec('diagnostics.next') end,      maps.extend_default_opt({ desc = 'Diagnostics: Next' }) },
    { "n", "<leader>db", function() pexec.exec('diagnostics.buffer') end,    maps.extend_default_opt({ desc = 'Diagnostics: Show Buffer' }) },
    { "n", "<leader>dw", function() pexec.exec('diagnostics.workspace') end, maps.extend_default_opt({ desc = 'Diagnostics: Show Workspace' }) },
}
