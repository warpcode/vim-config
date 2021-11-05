local wvim = require('warpcode.utils.vim')

return function (pm)
    local repos = {
        ['tpope/vim-fugitive'] = {
            disable = not wvim.has_executable('git')
        },
        ['airblade/vim-gitgutter'] = {
            disable = not wvim.has_executable('git')
        },
        ['junegunn/gv.vim'] = {
            disable = not wvim.has_executable('git')
        },
        ['tveskag/nvim-blame-line'] = {
            disable = not wvim.has_executable('git')
        },
    }

    pm:load_packages(repos)
end
