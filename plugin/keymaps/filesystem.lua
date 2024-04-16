local pexec = require 'warpcode.priority-exec'
local maps = require "warpcode.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('fs.find_files', function() vim.fn.feedkeys ':find ' end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "<leader>ff", function() pexec.exec('fs.find_files') end, maps.extend_default_opt({ desc = 'FS: Find Files' }) },
}
