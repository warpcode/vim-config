local null_ls = require 'null-ls'
local path = require('warpcode.utils.path')
local bin_stylelint = path.find_exe_path('stylelint')

return {
    null_ls.builtins.diagnostics.stylelint.with({
        command = bin_stylelint,
    }),
    null_ls.builtins.formatting.stylelint.with({
        command = bin_stylelint,
    }),
}
