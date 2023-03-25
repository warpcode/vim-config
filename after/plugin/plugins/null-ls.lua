pcall(function()
    local null_ls = require 'null-ls'
    null_ls.setup({
        debug = false,
        on_attach = require 'warpcode.lsp.null_ls'.custom_attach,
        -- diagnostics_format = "[#{s}] #{m} [#{c}]"
    })

    require "warpcode.lsp.null_ls".setup_servers()
end)
