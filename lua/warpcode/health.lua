local M = {}

local required_modules = {
  'warpcode.utils.terminal',
  'warpcode.utils.commands',
  'warpcode.utils.priority-queue',
  'warpcode.utils.keymap-actions',
  'warpcode.settings',
  'warpcode.keymaps',
}

local required_tools = {
  'git',
  'rg',
  'fd',
  'lazygit',
}

function M.check()
  vim.health.start("warpcode")

  -- Check Neovim version
  vim.health.info("Checking Neovim version")
  if vim.fn.has('nvim-0.9.0') == 1 then
    vim.health.ok("Neovim version is 0.9.0 or newer")
  else
    vim.health.error("Neovim version must be at least 0.9.0")
  end

  -- Check External Tools
  vim.health.info("Checking external tools")
  for _, tool in ipairs(required_tools) do
    if vim.fn.executable(tool) == 1 then
      vim.health.ok(tool .. " is installed")
    else
      vim.health.warn(tool .. " is not installed")
    end
  end

  -- Check core modules
  vim.health.info("Checking warpcode core modules")
  for _, mod in ipairs(required_modules) do
    local ok, _ = pcall(require, mod)
    if ok then
      vim.health.ok("Module " .. mod .. " loaded successfully")
    else
      vim.health.error("Module " .. mod .. " failed to load")
    end
  end
end

return M
