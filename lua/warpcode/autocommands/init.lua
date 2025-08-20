-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('warpcode-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local group = vim.api.nvim_create_augroup('warpcode-line-numbers', { clear = true })
local function set_line_numbers(relative)
  if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'modifiable') then
    vim.opt.number = false
    return
  end

  vim.opt.number = true
  vim.opt.relativenumber = relative
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  desc = 'Enable relative line numbers',
  group = group,
  callback = function()
    set_line_numbers(true)
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  desc = 'Disable relative line numbers',
  group = group,
  callback = function()
    set_line_numbers(false)
  end,
})
