local pexec = require 'warpcode.utils.priority-exec'
local maps = require "warpcode.utils.keymaps"

-- Default actions for lsp keymaps
pexec.addCall('fs.file_tree', function() vim.cmd 'Lexplore' end, 0)
pexec.addCall('fs.find_buffer', function() vim.api.nvim_input ':let @/=expand("%:t") <Bar> execute \'Lexplore\' expand("%:h") <Bar> normal n<CR>' end, 0)
pexec.addCall('fs.find_files', function() vim.api.nvim_input ':find ' end, 0)
pexec.addCall('fs.find_recent_files', function() vim.api.nvim_input ":oldfiles<CR>" end, 0)

maps.map_list {
    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "<leader>ft", function() pexec.exec('fs.file_tree') end, maps.extend_default_opt({ desc = 'FS: File Tree' }) },
    { "n", "<leader>fb", function() pexec.exec('fs.find_buffer') end, maps.extend_default_opt({ desc = 'FS: Find Buffer in File Tree' }) },
    { "n", "<leader>ff", function() pexec.exec('fs.find_files') end, maps.extend_default_opt({ desc = 'FS: Find Files' }) },
    { "n", "<leader>fr", function() pexec.exec('fs.find_recent_files') end, maps.extend_default_opt({ desc = 'FS: Find Recent Files' }) },
}
