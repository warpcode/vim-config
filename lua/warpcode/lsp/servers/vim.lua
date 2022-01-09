local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_vimls = path.find_exe_path('vim-language-server')

if bin_vimls then 
    lspconfig.vimls.setup(config.common({
        cmd = {bin_vimls, '--stdio'},
    }))
end

