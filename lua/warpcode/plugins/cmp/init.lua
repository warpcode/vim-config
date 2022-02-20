local M = {
    source = 'hrsh7th/nvim-cmp',
    config = require 'warpcode.plugins.cmp.config',
    run = function()
        vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/node" && npm i\' | redraw', false)
        vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/php" && php ' .. vim.g.vim_source .. '/bin/composer.phar install\' | redraw', false)
    end,
    requires = {
        'cmp_buffer',
        'cmp_calc',
        'cmp_cmdline',
        'cmp_emoji',
        'cmp_nvim_lsp',
        'cmp_nvim_lua',
        'cmp_omni',
        'cmp_path',
        'cmp_treesitter',
        'cmp_tabnine',
        'cmp_luasnip',
        'lspkind',
    }
}

return M
