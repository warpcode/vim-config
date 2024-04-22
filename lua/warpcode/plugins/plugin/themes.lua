return {
  -- [[ Themes ]]
  'RRethy/nvim-base16',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- vim.cmd.colorscheme('base16-gruvbox-dark-hard')
  end,
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },
}
