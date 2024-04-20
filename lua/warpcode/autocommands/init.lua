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

local group = vim.api.nvim_create_augroup('warpcode-lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  desc = 'When entering a buffer, set line numbers to relative',
  group = group,
  callback = function()
    if not vim.api.nvim_buf_get_option(vim.api.nvim_get_buf(), 'modifiable') then
      vim.opt.number = false
      return
    end

    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  desc = 'When leaving a buffer, set line numbers to absolute',
  group = group,
  callback = function()
    if not vim.api.nvim_buf_get_option(vim.api.nvim_get_buf(), 'modifiable') then
      vim.opt.number = false
      return
    end

    vim.opt.number = true
    vim.opt.relativenumber = false
  end,
})
