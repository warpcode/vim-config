pcall(function()
    require 'warpcode.lsp.null-ls'.add_server {
        package = 'jsonlint',
        config = require "null-ls".builtins.diagnostics.jsonlint,
    }

    require 'warpcode.lsp.null-ls'.add_server {
        config = require "null-ls".builtins.formatting.json_tool,
    }

    require 'warpcode.lsp.null-ls'.add_server {
        package = 'fixjson',
        config = require "null-ls".builtins.formatting.fixjson,
    }
end)

