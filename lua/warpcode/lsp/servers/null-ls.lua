local packages = require('warpcode.utils.packages')

if not packages.is_loaded('null-ls.nvim') then
    return
end

local null_ls = require('null-ls')

local sources = {
    -- JSON
    null_ls.builtins.diagnostics.jsonlint.with({
        command = vim.g.vim_source .. '/node_modules/.bin/jsonlint',
    }),

    -- PHP
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.formatting.phpcbf.with({
        command = vim.g.vim_source .. '/php_modules/bin/phpcbf',
        args = {'--standard=PSR12', '-'},
    }),
    null_ls.builtins.diagnostics.phpcs.with({
        command = vim.g.vim_source .. '/php_modules/bin/phpcs',
        args = {'--standard=PSR12', '--report=json', '-s', '-'},
    }),
    null_ls.builtins.formatting.phpcsfixer.with({
        command = vim.g.vim_source .. '/php_modules/bin/php-cs-fixer',
    }),
}

null_ls.setup({ sources = sources })
