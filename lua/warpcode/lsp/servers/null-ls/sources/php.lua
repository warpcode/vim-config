local null_ls = require 'null-ls'
local path = require('warpcode.utils.path')
local bin_phpcbf = path.find_exe_path('phpcbf')
local bin_phpcs = path.find_exe_path('phpcs')
local bin_phpcsfixer = path.find_exe_path('php-cs-fixer')

return {
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.formatting.phpcbf.with({
        command = bin_phpcbf,
        extra_args = {
            '--standard=PSR12',
        },
    }),
    null_ls.builtins.diagnostics.phpcs.with({
        command = bin_phpcs,
        extra_args = {
            '--standard=PSR12', 
        },
    }),
    null_ls.builtins.formatting.phpcsfixer.with({
        command = bin_phpcsfixer,
    }),
}
