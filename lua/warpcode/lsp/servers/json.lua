local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_jsonls = path.find_exe_path('vscode-json-language-server')

if bin_jsonls ~= '' then 
    lspconfig.jsonls.setup(config.common({
        cmd = {bin_jsonls, '--stdio'},
    }))
end

