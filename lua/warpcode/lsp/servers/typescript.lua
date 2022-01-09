local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_tsserver = path.find_exe_path('typescript-language-server')

if bin_tsserver then 
    lspconfig.tsserver.setup(config.common({
        cmd = {bin_tsserver, '--stdio'},
    }))
end
