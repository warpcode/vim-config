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


-- -- git
-- "commitlint",
-- "gitlint",

-- -- 'javascript'
-- "eslint_d",
-- "dprint",
-- "rome",
-- "xo",

-- -- 'json',
-- "cfn-lint",
-- "dprint",
-- "jq",

-- -- markdown
-- "alex",
-- "markdownlint",
-- "proselint",
-- "vale",
-- "write_good",
-- "cbfmt",
-- "dprint",

-- -- 'php',
-- "phpmd",
-- "phpstan",
-- "psalm",
-- "pint",

-- -- 'shell',
-- "shellcheck",
-- "beautysh",
-- "shellharden",
-- "shfmt",

-- -- 'sql',
-- "sql_formatter",
-- "sqlfluff",

-- -- 'yaml',
-- "actionlint",
-- "cfn-lint",
-- "yamllint",
-- },
--
    -- Dockerfile
    -- Disablebed as sentinel one sees it as a virus
    -- {
    --     package = 'hadolint',
    --     config = require "null-ls".builtins.diagnostics.hadolint,
    -- },

    -- Git

    -- Javascript
    -- {
    --     package = "eslint_d",
    --     config = require "null-ls".builtins.code_actions.eslint_d,
    -- },
    -- {
    --     package = "eslint_d",
    --     config = require "null-ls".builtins.diagnostics.eslint_d,
    -- },
    -- {
    --     package = "xo",
    --     config = require "null-ls".builtins.code_actions.xo,
    -- },
    -- {
    --     package = "xo",
    --     config = require "null-ls".builtins.diagnostics.xo,
    -- },

    -- Lua
    -- Disabled, Requires luarocks
    -- {
    --     package = 'luacheck',
    --     config = require "null-ls".builtins.diagnostics.luacheck,
    -- },
    -- Disabled, annoying until configured properly
    -- {
    --     package = 'selene',
    --     config = require "null-ls".builtins.diagnostics.selene,
    -- },
    -- Disabled. Causing formatting errors
    -- {
    --     package = 'stylua',
    --     config = require "null-ls".builtins.formatting.stylua,
    -- },

    -- Shell
    -- "shellcheck",
    -- "shellharden",
    -- "shfmt",
    -- Disabled. requires python venv
    -- {
    --     -- package = 'beautysh',
    --     config = null_ls.builtins.formatting.beautysh ,
    -- },

    -- Vim
    -- Disabled. Requires python3
    -- {
    --     package = 'vint',
    --     config = require "null-ls".builtins.diagnostics.vint,
    -- },

local M = {}
local null_ls = require "null-ls"
local servers = {}

---Add server to load
---@param config table
M.add_server = function(config)
    servers[#servers + 1] = config
end

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
