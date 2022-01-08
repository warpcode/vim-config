local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_bashls = path.find_exe_path('bash-language-server')

if bin_bashls ~= '' then 
    lspconfig.bashls.setup(config.common({
        cmd = {bin_bashls, 'start'},
    }))
end
