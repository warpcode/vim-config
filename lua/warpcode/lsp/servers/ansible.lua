local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_ansiblels = path.find_exe_path('ansible-language-server')


if bin_ansiblels ~= '' then 
    lspconfig.ansiblels.setup(config.common({
        cmd = {bin_ansiblels, '--stdio'},
    }))
end
