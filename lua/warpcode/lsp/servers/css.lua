local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_cssls = path.find_exe_path('vscode-css-language-server')

if bin_cssls ~= '' then 
    lspconfig.cssls.setup(config.common({
        cmd = {bin_cssls, '--stdio'},
    }))
end
