local wvim = require('warpcode.utils.vim')

return function (pm)
    local repos = {
        ['bronson/vim-trailing-whitespace'] = {},
        ['lukas-reineke/indent-blankline.nvim'] = {
            disable = wvim.is_vim()
        },
        ['Yggdroot/indentLine'] = {
            disable = wvim.is_nvim()
        },
        -- ['sheerun/vim-polyglot'] = {},

        -- Neovim Tree shitter
        ['nvim-treesitter/nvim-treesitter'] = {
            run = ':TSUpdate',
            disable = wvim.is_vim()
        },
        ['nvim-treesitter/playground'] = {
            disable = wvim.is_vim()
        }
    }

    pm:load_packages(repos)
end
