pcall(function()
    require 'warpcode.lsp.null-ls'.add_server {
        config = require "null-ls".builtins.diagnostics.php,
    }

    require 'warpcode.lsp.null-ls'.add_server {
        package = 'phpcbf',
        config = require "null-ls".builtins.formatting.phpcbf.with({
            extra_args = {
                "--standard=PSR12",
            },
        })
    }

    require 'warpcode.lsp.null-ls'.add_server {
        package = 'phpcs',
        config = require "null-ls".builtins.diagnostics.phpcs.with({
            extra_args = {
                "--standard=PSR12",
            },
        })
    }

    require 'warpcode.lsp.null-ls'.add_server {
        package = 'php-cs-fixer',
        config = require "null-ls".builtins.formatting.phpcsfixer.with({
            extra_args = {
                '--rules=@PSR12',
            }
        }),
    }
end)
