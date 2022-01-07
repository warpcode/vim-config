local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_tsserver = path.find_exe_path('typescript-language-server')


if bin_tsserver ~= '' then 
    -- lspconfig.tsserver.setup(config.common({
    --     cmd = {bin_tsserver, '--stdio'},
    -- }))
end

