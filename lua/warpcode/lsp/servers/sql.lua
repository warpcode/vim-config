local packages = require('warpcode.utils.packages')

if not packages.is_loaded('nvim-lspconfig') then
    return
end

local config = require('warpcode.lsp.config')
local lspconfig = require('lspconfig')
local util = require 'lspconfig.util'
local path = require('warpcode.utils.path')
local bin_sqlls = path.find_exe_path('sql-language-server')


if bin_sqlls ~= '' then 
    lspconfig.sqlls.setup(config.common({
        cmd = {bin_sqlls, 'up', '--method', 'stdio'},
        root_dir = function(fname)
            return util.root_pattern'.sqllsrc.json'(fname) or util.find_git_ancestor(fname)
        end
    }))
end
