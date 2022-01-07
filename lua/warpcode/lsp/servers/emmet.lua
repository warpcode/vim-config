local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_emmet_ls = path.find_exe_path('emmet-ls')


if bin_emmet_ls ~= '' then 
    lspconfig.emmet_ls.setup(config.common({
        cmd = {bin_emmet_ls, '--stdio'},
    }))
end

