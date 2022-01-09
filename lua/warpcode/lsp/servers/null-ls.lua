local null_ls_status, null_ls = pcall(require, 'null-ls')

if (not null_ls_status) then
    return
end

local path = require('warpcode.utils.path')
local attachments = require('warpcode.lsp.attachments')
local bin_eslint = path.find_exe_path('eslint')
local bin_jsonlint = path.find_exe_path('jsonlint')
local bin_fixjson = path.find_exe_path('fixjson')
local bin_phpcbf = path.find_exe_path('phpcbf')
local bin_phpcs = path.find_exe_path('phpcs')
local bin_phpcsfixer = path.find_exe_path('php-cs-fixer')

local sources = {
    -- Javascript
    null_ls.builtins.code_actions.eslint.with({
        command = bin_eslint,
    }),
    null_ls.builtins.diagnostics.eslint.with({
        command = bin_eslint,
    }),
    null_ls.builtins.formatting.eslint.with({
        command = bin_eslint,
    }),
    -- JSON
    null_ls.builtins.diagnostics.jsonlint.with({
        command = bin_jsonlint,
    }),
    null_ls.builtins.formatting.json_tool,
    null_ls.builtins.formatting.fixjson.with({
        command = bin_fixjson,
    }),

    -- PHP
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

null_ls.setup({
    debug = false,
    sources = sources,
    on_attach = attachments.common,
})
