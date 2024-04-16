require 'warpcode.keymaps'.map_list {
    -- Buffers
    { 'n', '<leader>bb', function()
        require('telescope.builtin').buffers()
    end },
    { 'n', '<leader>bp', ':bp<CR>' },
    { 'n', '<leader>bn', ':bn<CR>' },
    { 'n', '<leader>bc', ':bd<CR>' },
    { 'n', '<leader>bq', ':bp <BAR> bd #<cr>' },

    -- File Explorer
    { 'n', '<leader>nw', ':Lexplore<CR>' },

    -- File Finder
    { 'n', '<leader>ff', function()
        require('warpcode.plugins.telescope.finders').project_files()
    end },
    -- Recent files
    -- File Finder
    { 'n', '<leader>fr', function() require 'telescope.builtin'.oldfiles({ cwd_only = true }) end },
}
