return function (pm)
    local repos = {
        ['chriskempson/base16-vim'] = {},
        ['flazz/vim-colorschemes'] = {},
        ['gruvbox-community/gruvbox'] = {
            packer = {
                run = function ()
                    vim.cmd('colorscheme gruvbox')
                end
            },
            ['vim-plug'] = {
                on = 'VimEnter',
                config = function ()
                    vim.cmd('colorscheme gruvbox')
                   print('test')
                end
            }
        }
    }

    pm:load_packages(repos)
end
