local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
local bin_intelephense = path.find_exe_path('intelephense')
local bin_phpactor = path.find_exe_path('phpactor')

-- if bin_phpactor then 
--     lspconfig.phpactor.setup(config.common({
--         cmd = {bin_phpactor, 'language-server'},
--     }))
-- end

if bin_intelephense then 
    lspconfig.intelephense.setup(config.common({
        cmd = {bin_intelephense, '--stdio'},
    }))
end
