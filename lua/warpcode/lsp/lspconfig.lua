local M = {}
local servers = {
    {
        package = 'bash-language-server',
        lspconfig = 'bashls',
    },
    {
        package = 'dockerfile-language-server',
        lspconfig = 'dockerls',
    },
    {
        package = 'emmet-ls',
        lspconfig = 'emmet_ls',
    },
    {
        package = 'html-lsp',
        lspconfig = 'html',
    },
    {
        package = 'intelephense',
        lspconfig = 'intelephense',
    },
    {
        package = 'json-lsp',
        lspconfig = 'jsonls',
    },
    {
        package = 'lua-language-server',
        lspconfig = 'lua_ls',
        config = {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        vim.split(package.path, ";"),
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
        -- validate = function()
        --     return vim.env.IS_WORK ~= 1
        -- end
    },
    {
        package = 'sqlls',
        lspconfig = 'sqlls',
        config = {
            root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern(".sqllsrc.json")(fname) or util.find_git_ancestor(fname)
            end,
        }
    },
    {
        package = 'typescript-language-server',
        lspconfig = 'tsserver',
    },
    {
        package = 'vim-language-server',
        lspconfig = 'vimls',
        validate = function()
            return vim.env.IS_WORK ~= 1
        end
    },
}

---Get the list of usable servers
---@return table
M.get_usable_servers = function()
    local usable_servers = {}

    for _, p in pairs(servers) do
        local validate = p.validate or function() return true end
        if type(validate) == 'function' and validate() then
            usable_servers[#usable_servers + 1] = p
        end
    end

    return usable_servers
end

---Get the list of packages available
---@return table
M.get_packages = function()
    local packages = {}

    for _, p in pairs(M.get_usable_servers()) do
        local package = p.package or ''
        if string.len(package) > 0 then
            packages[#packages + 1] = package
        end
    end

    return packages
end

---Run some required init tasks
---@param client table
M.custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

---Custom attach procedure
---@param client table
---@param bufnr number
M.custom_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('warpcode.keymaps.lsp').common(client, bufnr)

    if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    end

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

---Custom capabilities checks
---@return table
M.custom_capabilities = function()
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end

---Instantly setup an lsp
---@param server string
---@param config table
M.setup_server = function(server, config)
    if type(config) == "function" then
        config = config()
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

---Setup lspconfig with all the usabe servers
M.setup_servers = function()
    local setup_servers = M.get_usable_servers()

    for _, p in pairs(M.get_usable_servers()) do
        M.setup_server(p.lspconfig, p.config)
    end
end

return M
