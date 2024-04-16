pcall(function()
    require 'warpcode.lsp.null-ls'.add_server {
        package = 'prettier',
        config = require "null-ls".builtins.formatting.prettier,
    }
end)
