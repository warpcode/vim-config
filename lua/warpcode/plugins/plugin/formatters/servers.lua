-- This will be included where mason is setup to run
local M = {}

M.servers = {
  _ = { 'prettier' },
  json = { 'fixjson' },
  lua = { 'stylua' },
  php = { 'php_cs_fixer' },
  python = { 'black', 'isort' },
}

M.mason_ignore = {}

M.mason_mapping = {
  php_cs_fixer = 'php-cs-fixer',
}

M.formatters_override = {}

M.get_mason_tool_names = function()
  local tools = {}

  for _, x in pairs(M.servers) do
    local ft_tools = vim.deepcopy(x)

    for _, value in pairs(ft_tools) do
      if not vim.tbl_contains(M.mason_ignore, value) then
        tools[#tools + 1] = M.mason_mapping[value] or value
      end
    end
  end

  return tools
end

return M
