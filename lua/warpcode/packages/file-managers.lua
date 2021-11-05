return function (pm)
    local repos = {
        ['junegunn/fzf'] = {
            run = function ()
                vim.fn['fzf#install']()
            end,
        },
        ['junegunn/fzf.vim'] = {},
        ['scrooloose/nerdtree'] = {},
        ['jistr/vim-nerdtree-tabs'] = {},
        ['Xuyuanp/nerdtree-git-plugin'] = {},
    }

    pm:load_packages(repos)
end
