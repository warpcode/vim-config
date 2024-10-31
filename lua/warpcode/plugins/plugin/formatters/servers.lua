-- This will be included where mason is setup to run
local M = {}

M.servers = {
    css = { 'prettier' },
    html = { 'prettier' },
    javascript = { 'prettier' },
    json = { 'fixjson', 'prettier' },
    jsx = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    php = { 'phpcbf', 'php_cs_fixer' },
    scss = { 'prettier' },
    typescript = { 'prettier' },
    vue = { 'prettier' },
    yaml = { 'prettier' },
}

M.mason_ignore = {}

M.mason_mapping = {
    php_cs_fixer = 'php-cs-fixer',
}

M.formatters_override = {
    phpcbf = {
        prepend_args = { "--standard=PSR12" },
    },
    php_cs_fixer = {
        append_args = { '--allow-risky=yes' },
    },
}

M.get_mason_tool_names = function()
    local tools = {}

    for _, x in pairs(M.servers) do
        local ft_tools = vim.deepcopy(vim.deepcopy(x))

        for key, value in pairs(ft_tools) do
            if not vim.tbl_contains(M.mason_ignore, value) then
                tools[#tools+1] = M.mason_mapping[value] or value
            end
        end
    end

    return tools
end

return M
