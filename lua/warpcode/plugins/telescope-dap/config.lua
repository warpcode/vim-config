local status, tdap = pcall(require, 'telescope-dap')

return {
    run = function()
        if not status then return end

        require('telescope').load_extension('dap')
        -- vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
        -- -- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
        -- vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
    end
}
