-- {

-- asciidoc
-- "vale",

-- -- cmake
-- "cmake_format",
-- "gersemi",

-- -- cpp
-- "cpplint",
-- "clang_format",

-- -- cs
-- "clang_format",
-- "csharpier",

-- -- 'css',
-- "prettier",
-- "prettierd",

-- -- git
-- "commitlint",
-- "gitlint",

-- -- html
-- "prettier",
-- "prettierd",

-- -- 'javascript'
-- "eslint_d",
-- "prettier",
-- "prettierd",
-- "dprint",
-- "rome",
-- "xo",

-- -- 'json',
-- "cfn-lint",
-- "jsonlint",
-- "dprint",
-- "fixjson",
-- "jq",
-- "prettier",
-- "prettierd",

-- -- 'lua',
-- "luacheck",
-- -- "selene",
-- "stylua",

-- -- markdown
-- "alex",
-- "markdownlint",
-- "proselint",
-- "vale",
-- "write_good",
-- "cbfmt",
-- "dprint",
-- "prettier",
-- "prettierd",

-- -- 'php',
-- "phpcs",
-- "phpmd",
-- "phpstan",
-- "psalm",
-- "phpcbf",
-- "phpcsfixer",
-- "pint",

-- -- 'shell',
-- "shellcheck",
-- "beautysh",
-- "shellharden",
-- "shfmt",

-- -- 'sql',
-- "sql_formatter",
-- "sqlfluff",

-- -- 'vim',
-- "vint",

-- -- 'yaml',
-- "actionlint",
-- "cfn-lint",
-- "yamllint",
-- "prettier",
-- "prettierd",
-- },

local M = {}
local null_ls = require "null-ls"
local servers = {
    -- Dockerfile
    {
        package = 'hadolint',
        config = require "null-ls".builtins.diagnostics.hadolint,
    },

    -- json
    {
        package = 'fixjson',
        config = require "null-ls".builtins.formatting.fixjson,
    },

    -- PHP
    {
        config = require "null-ls".builtins.diagnostics.php,
    },
    {
        package = 'phpcbf',
        config = require "null-ls".builtins.formatting.phpcbf.with({
            extra_args = {
                "--standard=PSR12",
            },
        })
    },
    {
        package = 'phpcs',
        config = require "null-ls".builtins.diagnostics.phpcs.with({
            extra_args = {
                "--standard=PSR12",
            },
        })
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

---Custom attach procedure
---@param client table
---@param bufnr number
M.custom_attach = function(client, bufnr)
    require "warpcode.lsp.lspconfig".custom_attach(client, bufnr)
end

---Instantly setup an lsp
---@param config table
M.setup_server = function(config)
    if type(config) == 'function' then
        config = config()
    end

    if not config then
        return
    end

    null_ls.register(config)
end

---Setup null ls with all the usabe servers
M.setup_servers = function()
    for _, p in pairs(M.get_usable_servers()) do
        M.setup_server(p.config)
    end
end

return M
