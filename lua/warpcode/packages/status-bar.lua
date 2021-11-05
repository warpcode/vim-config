return function (pm)
    local repos = {
        ['vim-airline/vim-airline'] = {},
        ['vim-airline/vim-airline-themes'] = {}
    }

    pm:load_packages(repos)
end
