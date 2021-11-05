local wvim = require('warpcode.utils.vim')

return function (pm)
    local repos = {
        -- Instal CoC.
        ['neoclide/coc.nvim'] = {
            branch = 'release'
        },

        -- Languages
        ['neoclide/coc-css'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-eslint'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-json'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-highlight'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-html'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['xiyaowong/coc-sumneko-lua'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['marlonfan/coc-phpls'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['josa42/coc-sh'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-tsserver'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['iamcco/coc-vimlsp'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },

        -- Utilities
        ['iamcco/coc-diagnostic'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-emmet'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-lists'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        ['neoclide/coc-snippets'] = {
            run = wvim.get_var('vim_node_bin', 'g') .. '/yarn install --frozen-lockfile'
        },
        -- Snippet Collections
        ['honza/vim-snippets'] = {}
    }

    pm:load_packages(repos)
end
