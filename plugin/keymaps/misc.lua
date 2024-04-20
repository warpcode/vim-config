require('warpcode.utils.keymaps').map_list({
  -- Map semicolon to colon to write commands without needing to hit shift
  { 'n', ';', ':' },
  { 'v', ';', ':' },

  -- Insert mode easy escape
  { 'i', 'jk', '<ESC>' },
  { 'i', 'kj', '<ESC>' },
})
