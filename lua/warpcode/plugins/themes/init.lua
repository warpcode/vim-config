local M = {
    source = 'RRethy/nvim-base16',
    config = function()
        pcall(function()
            vim.api.nvim_exec([[colorscheme base16-gruvbox-dark-hard]], false)
        end)
    end,
}

return M
