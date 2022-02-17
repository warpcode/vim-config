local null_ls = require 'null-ls'
local path = require('warpcode.utils.path')
local bin_jsonlint = path.find_exe_path('jsonlint')
local bin_fixjson = path.find_exe_path('fixjson')

return {
    null_ls.builtins.diagnostics.jsonlint.with({
        command = bin_jsonlint,
    }),
    null_ls.builtins.formatting.json_tool,
    null_ls.builtins.formatting.fixjson.with({
        command = bin_fixjson,
    }),
}
