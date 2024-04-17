return {
    -- [[ Themes ]]
    'RRethy/nvim-base16',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        vim.cmd.colorscheme 'base16-gruvbox-dark-hard'
    end,
}
