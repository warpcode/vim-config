-- local config = require('warpcode.utils.lsp').config

-- require("lspconfig").cssls.setup(config({
--     cmd = {vim.g.vim_source .. '/node_modules/.bin/vscode-css-language-server', '--stdio'},
-- }))
local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local path = require('warpcode.utils.path')
local bin_cssls = path.find_exe_path('vscode-css-language-server')


if bin_cssls ~= '' then 
    lspconfig.cssls.setup(config.common({
        cmd = {bin_cssls, '--stdio'},
    }))
end
