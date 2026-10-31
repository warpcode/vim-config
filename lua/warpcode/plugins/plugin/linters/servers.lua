-- This will be included where mason is setup to run
local M = {}

M.servers = {
  json = { 'jsonlint' },
  markdown = { 'markdownlint' },
  php = { 'php', 'phpcs' },
  python = { 'flake8' },
  zsh = { 'zsh' },
}

M.mason_ignore = {
  'php',
  'zsh',
}

M.args_override = {
  phpcs = {
    '-q',
    '--standard=PSR12',
    '--report=json',
    '-',
  },
}

M.get_mason_tool_names = function()
  local tools = {}

  for _, x in pairs(M.servers) do
    for _, value in pairs(x) do
      if not vim.tbl_contains(M.mason_ignore, value) then
        tools[#tools + 1] = value
      end
    end
  end

  return tools
end

return M
