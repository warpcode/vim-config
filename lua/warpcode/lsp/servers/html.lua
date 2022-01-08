local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_html = path.find_exe_path('vscode-html-language-server')

if bin_html ~= '' then 
    lspconfig.html.setup(config.common({
        cmd = {bin_html, '--stdio'},
    }))
end
