local config = require('warpcode.lsp.config')
local util = require('lspconfig.util')
require "lspconfig".sqlls.setup(config.common({
    root_dir = function(fname)
        return util.root_pattern '.sqllsrc.json' (fname) or util.find_git_ancestor(fname)
    end
}))
