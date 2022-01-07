local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_bashls = path.find_exe_path('bash-language-server')


if bin_bashls ~= '' then 
    lspconfig.bashls.setup(config.common({
        cmd = {bin_bashls, 'start'},
    }))
end
