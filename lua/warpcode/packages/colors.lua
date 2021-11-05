return function (pm)
    local repos = {
        ['chriskempson/base16-vim'] = {},
        ['flazz/vim-colorschemes'] = {},
        ['gruvbox-community/gruvbox'] = {
            config = function ()
                vim.cmd('colorscheme gruvbox')
            end
        }
    }

    pm:load_packages(repos)
end
