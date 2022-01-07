local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_dockerls = path.find_exe_path('docker-langserver')

if bin_dockerls ~= '' then 
    lspconfig.dockerls.setup(config.common({
        cmd = {bin_dockerls, '--stdio'},
    }))
end

