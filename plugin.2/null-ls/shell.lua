pcall(function()
    require 'warpcode.lsp.null-ls'.add_server {
        config = require "null-ls".builtins.diagnostics.zsh,
    }
end)
