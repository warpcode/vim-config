local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_html = path.find_exe_path('vscode-html-language-server')


if bin_html ~= '' then 
    lspconfig.html.setup(config.common({
        cmd = {bin_html, '--stdio'},
    }))
end
