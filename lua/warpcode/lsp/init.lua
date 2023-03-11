-- vim.lsp.set_log_level("debug")

local format_diagnostic = function(diagnostic)
    return string.format('[%s] %s', diagnostic.source, diagnostic.message)
end

vim.diagnostic.config({
    float = {
        format = format_diagnostic,
    },
    virtual_text = {
        format = format_diagnostic,
    },
})


local wtables = require('warpcode.utils.tables')
local default_server_configs = {
    ansiblels = {
        settings = {
            ansible = {
                python = {
                    interpreterPath = require('warpcode.utils.path').find_exe_path('python3') or
                        require('warpcode.utils.path').find_exe_path('python'),
                },
                ansibleLint = {
                    path = 'ansible-lint',
                    enabled = true,
                },
                ansible = {
                    path = 'ansible',
                },
                executionEnvironment = {
                    enabled = false,
                },
            },
        },
    },
    bashls = {},
    cssls = {},
    dockerls = {},
    emmet_ls = {},
    html = {},
    intelephense = {},
    jsonls = {},
    lua_ls = {
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
    },
    rust_analyzer = {},
    sqlls = {
        root_dir = function(fname)
            local util = require('lspconfig.util')
            return util.root_pattern '.sqllsrc.json' (fname) or util.find_git_ancestor(fname)
        end
    },
    tsserver = {},
    vimls = {},
}


for server, config in pairs(default_server_configs) do
    require'warpcode.plugins.lsp.lspconfig'.setup_lsp_config_server(server, config)
end

require 'null-ls'.setup({
    debug = false,
    sources = wtables.list_extend(wtables.table_unpack({
        require 'warpcode.lsp.servers.null-ls.sources.css',
        require 'warpcode.lsp.servers.null-ls.sources.json',
        require 'warpcode.lsp.servers.null-ls.sources.php',
        require 'warpcode.lsp.servers.null-ls.sources.typescript',
    })),
    on_attach = require'warpcode.plugins.lsp.lspconfig'.custom_attach,
    -- diagnostics_format = "[#{s}] #{m} [#{c}]"
})

