local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_vimls = path.find_exe_path('vim-language-server')

if bin_vimls ~= '' then 
    lspconfig.vimls.setup(config.common({
        cmd = {bin_vimls, '--stdio'},
    }))
end

