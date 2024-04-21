vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vim_home = vim.fn.stdpath('config')
vim.g.vim_source = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.stdpath('config') .. '/init.lua'), ':h')
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed

-- Backups
-- Do not create backups before saving
vim.opt.backup = false

-- Buffer
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Diagnostics
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

-- Formatting
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true -- Enable break indent

-- NETRW
vim.g.netrw_banner = 1 -- Leave the banner on. Setting clipboard to 'unnamedplus' causes flickering in netrw
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_browsesplit = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -40

-- Misc
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Decrease update time
vim.opt.updatetime = 250

-- Scroll
vim.opt.wrap = false
vim.opt.scrolljump = 1 -- scroll one line at a time
vim.opt.scrolloff = 999 -- Keep cursor in the vertical middle of the screen
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1

-- Search
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.guicursor = 'n-v-i-c:block-Cursor' --  Set cursor to fat cursor
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
vim.opt.relativenumber = false

vim.opt.cursorline = true -- Show which line your cursor is on
-- vim.opt.lazyredraw = false
vim.opt.redrawtime = 10000
vim.opt.linebreak = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80,120'
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '¬', extends = '>', precedes = '<' }

-- Undo
vim.opt.undofile = true
vim.opt.history = 10000
vim.opt.undolevels = 1000
