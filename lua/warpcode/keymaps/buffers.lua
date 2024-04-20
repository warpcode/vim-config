local pexec = require 'warpcode.utils.priority-exec'
local maps = require "warpcode.utils.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('buffers.browse', function() vim.api.nvim_input ':buffers<CR>' end, 0)
pexec.addCall('buffers.next', function() vim.api.nvim_input ':bn<CR>' end, 0)
pexec.addCall('buffers.previous', function() vim.api.nvim_input ':bp<CR>' end, 0)
pexec.addCall('buffers.close', function() vim.api.nvim_input ':bp <BAR> bd #<cr>' end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "<leader>bb", function() pexec.exec('buffers.browse') end, maps.extend_default_opt({ desc = 'Buffers: Browse Buffers' }) },
    { "n", "<leader>bn", function() pexec.exec('buffers.next') end, maps.extend_default_opt({ desc = 'Buffers: Next Buffer' }) },
    { "n", "<leader>bp", function() pexec.exec('buffers.previous') end, maps.extend_default_opt({ desc = 'Buffers: Previous Buffer' }) },
    { "n", "<leader>bq", function() pexec.exec('buffers.close') end, maps.extend_default_opt({ desc = 'Buffers: Close Buffer' }) },
}
