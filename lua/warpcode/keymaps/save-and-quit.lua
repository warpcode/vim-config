-- local maps = require('warpcode.utils.keymaps')
--
-- maps.map_list({
--   { 'ca', 'W!', 'w!', { noremap = true } },
--   { 'ca', 'Q!', 'q!', { noremap = true } },
--   { 'ca', 'Qall!', 'qall!', { noremap = true } },
--   { 'ca', 'Wq', 'wq', { noremap = true } },
--   { 'ca', 'Wa', 'wa', { noremap = true } },
--   { 'ca', 'wQ', 'wq', { noremap = true } },
--   { 'ca', 'WQ', 'wq', { noremap = true } },
--   { 'ca', 'W', 'w', { noremap = true } },
--   { 'ca', 'Q', 'q', { noremap = true } },
--   { 'ca', 'Qa', 'qa', { noremap = true } },
--   { 'ca', 'Qall', 'qall', { noremap = true } },
-- })
--

vim.cmd([[
  " Common abbreviation for typos
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qa qa
  cnoreabbrev Qall qall
]])
