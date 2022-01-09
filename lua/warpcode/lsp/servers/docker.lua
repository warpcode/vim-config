local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_dockerls = path.find_exe_path('docker-langserver')

if bin_dockerls then 
    lspconfig.dockerls.setup(config.common({
        cmd = {bin_dockerls, '--stdio'},
    }))
end

