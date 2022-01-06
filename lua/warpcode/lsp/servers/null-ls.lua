local packages = require('warpcode.utils.packages')

if not packages.is_loaded('null-ls.nvim') then
    return
end

local null_ls = require('null-ls')
local path = require('warpcode.utils.path')
local bin_jsonlint = path.find_exe_path('jsonlint')
local bin_phpcbf = path.find_exe_path('phpcbf')
local bin_phpcs = path.find_exe_path('phpcs')
local bin_phpcsfixer = path.find_exe_path('php-cs-fixer')

local sources = {
    -- JSON
    null_ls.builtins.diagnostics.jsonlint.with({
        command = bin_jsonlint,
    }),

    -- PHP
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.formatting.phpcbf.with({
        command = bin_phpcbf,
        args = {'--standard=PSR12', '-'},
    }),
    null_ls.builtins.diagnostics.phpcs.with({
        command = bin_phpcs,
        args = {'--standard=PSR12', '--report=json', '-s', '-'},
    }),
    null_ls.builtins.formatting.phpcsfixer.with({
        command = bin_phpcsfixer,
    }),
}

null_ls.setup({ sources = sources })
