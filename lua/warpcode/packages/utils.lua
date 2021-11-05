return function (pm)
    local repos = {
        -- Auto comment out code
        ['tpope/vim-commentary'] = {},

        -- Autoclose delimiters
        ['Raimondi/delimitMate'] = {},

        -- Change encapsulating quotes
        ['tpope/vim-surround'] = {},

        -- View man pages in vim
        ['vim-utils/vim-man'] = {},

        -- Visual way to explore vim's undo tree
        ['mbbill/undotree'] = {},
    }

    pm:load_packages(repos)
end
