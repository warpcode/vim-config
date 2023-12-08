local pexec = require 'warpcode.priority-exec'
local maps = require "warpcode.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('diagnostics.next', function() vim.diagnostic.goto_next() end, 0)
pexec.addCall('diagnostics.prev', function() vim.diagnostic.goto_prev() end, 0)
pexec.addCall('diagnostics.buffer', function() vim.diagnostic.setloclist() end, 0)
pexec.addCall('diagnostics.workspace', function() vim.diagnostic.setqflist() end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "[d", function() pexec.exec('diagnostics.prev') end, },
    { "n", "]d", function() pexec.exec('diagnostics.next') end, },
    { "n", "<leader>db", function() pexec.exec('diagnostics.buffer') end, },
    { "n", "<leader>dw", function() pexec.exec('diagnostics.workspace') end, },
}
