local M = {
    source = 'hrsh7th/nvim-cmp',
    config = function()
        require 'warpcode.plugins.cmp.config'.run()
    end,
    run = function()
        vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/node" && npm i\' | redraw', false)
        vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/php" && php ' .. vim.g.vim_source .. '/bin/composer.phar install\' | redraw', false)
    end,
}

return M
