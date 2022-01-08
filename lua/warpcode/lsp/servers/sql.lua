local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
local util = require('lspconfig.util')
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
