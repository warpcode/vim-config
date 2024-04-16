return {
    'nvim-tree/nvim-web-devicons', -- Lua fork of 'ryanoasis/vim-devicons'
    cond = function()
        return vim.g.have_nerd_font
    end,
}
