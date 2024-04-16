return {
    -- [[ Git ]]
    'tpope/vim-fugitive',
    dependencies = {
        'tpope/vim-rhubarb',
        -- 'airblade/vim-gitgutter',
        -- 'junegunn/gv.vim',   -- Git commit explorer/viewer
        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            -- This is like running require('gitsigns').setup({ ... })
            'lewis6991/gitsigns.nvim',
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                --     on_attach = function(bufnr)
                --       vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
                --
                --       -- don't override the built-in and fugitive keymaps
                --       local gs = package.loaded.gitsigns
                --       vim.keymap.set({ 'n', 'v' }, ']c', function()
                --         if vim.wo.diff then
                --           return ']c'
                --         end
                --         vim.schedule(function()
                --           gs.next_hunk()
                --         end)
                --         return '<Ignore>'
                --       end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
                --       vim.keymap.set({ 'n', 'v' }, '[c', function()
                --         if vim.wo.diff then
                --           return '[c'
                --         end
                --         vim.schedule(function()
                --           gs.prev_hunk()
                --         end)
                --         return '<Ignore>'
                --       end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
                --     end,
            },
        },
    },
}
