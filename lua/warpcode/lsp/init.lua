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

local M = {}

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

local setup_lsp_config_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = M.custom_init,
        on_attach = M.custom_attach,
        capabilities = M.updated_capabilities,
        flags = {
            debounce_text_changes = nil,
        },
    }, config)

    require 'lspconfig'[server].setup(config)
end

M.custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

M.custom_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('warpcode.lsp.keymaps').common(client, bufnr)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            group = group
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            group = group
        })

        vim.api.nvim_exec([[
            " hi LspReferenceRead cterm=bold ctermbg=239 guibg=#504945
            " hi LspReferenceText cterm=bold ctermbg=239 guibg=#504945
            " hi LspReferenceWrite cterm=bold ctermbg=243 guibg=#7c6f64
        ]], false)
    end
end

M.custom_capabilities = function()
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end


for server, config in pairs(default_server_configs) do
    setup_lsp_config_server(server, config)
end

require 'null-ls'.setup({
    debug = false,
    sources = wtables.list_extend(wtables.table_unpack({
        require 'warpcode.lsp.servers.null-ls.sources.css',
        require 'warpcode.lsp.servers.null-ls.sources.json',
        require 'warpcode.lsp.servers.null-ls.sources.php',
        require 'warpcode.lsp.servers.null-ls.sources.typescript',
    })),
    on_attach = M.custom_attach,
    -- diagnostics_format = "[#{s}] #{m} [#{c}]"
})

return M
