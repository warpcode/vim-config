local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_jsonls = path.find_exe_path('vscode-json-language-server')

if bin_jsonls ~= '' then 
    lspconfig.jsonls.setup(config.common({
        cmd = {bin_jsonls, '--stdio'},
    }))
end

