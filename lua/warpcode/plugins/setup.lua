-- [[ Setup lazy plugin manager ]]
local plugin_dir = 'warpcode.plugins.plugin.'

vim.g.have_nerd_font = true
require('lazy').setup({

  -- Toasts for lsp and notifications
  { 'j-hui/fidget.nvim', opts = {} },


  -- [[ Utilities ]]
  -- 'tpope/vim-abolish',
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- 'sudormrfbin/cheatsheet.nvim',
  -- 'tpope/vim-surround',
  -- 'bronson/vim-trailing-whitespace',    -- Removes excess whitespace
  -- 'vim-utils/vim-man',                  -- Load cli man pages in vim
  -- -- 'Raimondi/delimitMate',
  -- { 'numToStr/Comment.nvim', opt = {} }, -- better than 'tpope/vim-commentary'
  -- 'mbbill/undotree',
  -- 'simrat39/symbols-outline.nvim',
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      -- require('which-key').register {
      --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      -- }
    end,
  },



  -- Dependencies
  -- { 'nvim-lua/plenary.nvim' },
  -- { 'nvim-lua/popup.nvim' },
  -- { "williamboman/mason.nvim" },
  -- { "WhoIsSethDaniel/mason-tool-installer.nvim" },



  -- -- File Browser
  -- { 'scrooloose/nerdtree' },
  -- { 'Xuyuanp/nerdtree-git-plugin' },
  -- { 'jistr/vim-nerdtree-tabs' },
  --
  --
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      require('mini.indentscope').setup()
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    {
      'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
      main = 'ibl',
      opts = {},
    },
  },

  -- { import = 'custom.plugins' },

  -- [ Grouped plugins ]
  require(plugin_dir .. 'autocomplete'),
  require(plugin_dir .. 'fonts'),
  require(plugin_dir .. 'formatters'),
  require(plugin_dir .. 'linters'),
  require(plugin_dir .. 'telescope'),
  require(plugin_dir .. 'themes'),
  require(plugin_dir .. 'treesitter'),
  require(plugin_dir .. 'version-control'),


  -- UI
  -- -- Log
  -- { 'rcarriga/nvim-notify' }, -- Override notify method
  --
  -- -- Status line
  -- { 'vim-airline/vim-airline' },
  -- { 'vim-airline/vim-airline-themes' },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = 'onedark',
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --   },
  -- },

}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
