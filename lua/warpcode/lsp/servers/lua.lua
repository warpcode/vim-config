local lspconfig_status, lspconfig = pcall(require, 'lspconfig')

if (not lspconfig_status) then
    return
end

local config = require('warpcode.lsp.config')
    require("lspconfig").lua_ls.setup(config.common({
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    vim.split(package.path, ";")
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }))
