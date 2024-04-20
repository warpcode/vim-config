-- [[ Setup lazy plugin manager ]]
local plugin_dir = 'warpcode.plugins.plugin.'
local pexec = require 'warpcode.utils.priority-exec'

require('lazy').setup({

  -- Toasts for lsp and notifications
  { 'j-hui/fidget.nvim',     opts = {} },

  -- [[ Utilities ]]
  'bronson/vim-trailing-whitespace',     -- Removes excess whitespace
  'sudormrfbin/cheatsheet.nvim',
  'tpope/vim-abolish',
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-surround',
  'vim-utils/vim-man',                   -- Load cli man pages in vim
  -- 'Raimondi/delimitMate',
  { 'numToStr/Comment.nvim', opts = {} }, -- better than 'tpope/vim-commentary'
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

  -- -- File Browser
  {
    'scrooloose/nerdtree',
    dependencies = {
      { 'Xuyuanp/nerdtree-git-plugin' },
      { 'jistr/vim-nerdtree-tabs' },
    },
    config = function()
      vim.cmd [[
        let g:NERDTreeChDirMode=2
        let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
        let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
        let g:NERDTreeShowBookmarks=1
        let g:nerdtree_tabs_focus_on_files=1
        let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
        let g:NERDTreeWinSize = 40
        let g:NERDTreeShowHidden=1
        " Show ignored icon next to ignored files. This can be intensive with a lot of files
        let g:NERDTreeGitStatusShowIgnored = 1
        " List of icons for file statuses
        let g:NERDTreeGitStatusIndicatorMapCustom = {
                    \ "Modified"  : "✹",
                    \ "Staged"    : "✚",
                    \ "Untracked" : "✭",
                    \ "Renamed"   : "➜",
                    \ "Unmerged"  : "═",
                    \ "Deleted"   : "✖",
                    \ "Dirty"     : "✗",
                    \ "Clean"     : "✔︎",
                    \ 'Ignored'   : '☒',
                    \ "Unknown"   : "?"
                    \ }

        " NERDTree - Quit vim when all other windows have been closed.
        au BufEnter *
                    \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
                    \ b:NERDTreeType == "primary") |
                    \   q |
                    \ endif

        "
        " Auto find files in nerdtree on buf enter
        "
        " Check if NERDTree is open or active
        function! IsNERDTreeOpen()
            return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
        endfunction

        " Call NERDTreeFind if NERDTree is active, current window contains a modifiable
        " file, and we're not in vimdiff
        function! SyncTree()
            if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
                NERDTreeFind
                wincmd p
            endif
        endfunction

        " Highlight currently open buffer in NERDTree
        " autocmd BufEnter * call SyncTree()

        " With the auto find feature, ensure we don't double open nerdtree
        function! ToggleNerdTree()
            set eventignore=BufEnter
            NERDTreeToggle
            set eventignore=
        endfunction
        nnoremap <leader>t :call ToggleNerdTree()<CR>
        ]]

      pexec.addCall('fs.file_tree', function() vim.cmd 'NERDTreeToggle' end, 10)
      pexec.addCall('fs.find_buffer', function() vim.cmd 'NERDTreeFind' end, 10)
    end,
  },
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
      vim.api.nvim_command([[ highlight WinSeperator guibg=none ]])
      vim.opt.laststatus = 3

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
      config = function()
        vim.opt.termguicolors = true
        vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↴"

        require "ibl".setup {
          -- for example, context is off by default, use this to turn it on
          -- show_current_context = false,
          -- show_current_context_start = false,
          -- space_char_blankline = " ",

          -- char_highlight_list = {
          --     "IndentBlanklineIndent1",
          --     "IndentBlanklineIndent2",
          --     "IndentBlanklineIndent3",
          --     "IndentBlanklineIndent4",
          --     "IndentBlanklineIndent5",
          --     "IndentBlanklineIndent6",
          -- },
        }
      end,
    },
  },

  -- { import = 'custom.plugins' },

  -- [ Grouped plugins ]
  require(plugin_dir .. 'autocomplete'),
  require(plugin_dir .. 'fonts'),
  require(plugin_dir .. 'formatters'),
  require(plugin_dir .. 'linters'),
  require(plugin_dir .. 'lsp'),
  require(plugin_dir .. 'telescope'),
  require(plugin_dir .. 'themes'),
  require(plugin_dir .. 'treesitter'),
  require(plugin_dir .. 'version-control'),

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
