local null_ls = require 'null-ls'
local path = require('warpcode.utils.path')
local bin_eslint = path.find_exe_path('eslint')

return {
    null_ls.builtins.code_actions.eslint.with({
        command = bin_eslint,
    }),
    null_ls.builtins.diagnostics.eslint.with({
        command = bin_eslint,
    }),
    null_ls.builtins.formatting.eslint.with({
        command = bin_eslint,
    }),
}
