pcall(function()
    require 'warpcode.lsp.lspconfig'.add_server {
        package = 'sqlls',
        lspconfig = 'sqlls',
        config = {
            root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern(".sqllsrc.json")(fname) or util.find_git_ancestor(fname)
            end,
        }
    }
end)
