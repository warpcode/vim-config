local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_ansiblels = path.find_exe_path('ansible-language-server')


if bin_ansiblels ~= '' then 
    lspconfig.ansiblels.setup(config.common({
        cmd = {bin_ansiblels, '--stdio'},
    }))
end
