local p = require('warpcode.utils.keymap-actions')

return {
  -- [[ Git ]]
  'tpope/vim-fugitive',
  config = function()
    local km_priority = 10
    p.addCall('vcs.show_status', function()
      if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
        vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
      else
        if vim.fn.FugitiveHead() ~= '' then
          vim.cmd([[
            Git
            " wincmd H  " Open Git window in vertical split
            " setlocal winfixwidth
            " vertical resize 31
            " setlocal winfixwidth
            " setlocal nonumber
            " setlocal norelativenumber
          ]])
        end
      end
    end,
    km_priority)
  end,
  dependencies = {
    'tpope/vim-rhubarb',
    -- 'junegunn/gv.vim',   -- Git commit explorer/viewer
    {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      -- This is like running require('gitsigns').setup({ ... })
      'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add          = { text = '+' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local km_priority = 10

          -- We must wrap every call in functions else they throw errors
          p.addCall('vcs.hunk_first',    function() gs.nav_hunk("first") end,    km_priority, bufnr)
          p.addCall('vcs.hunk_previous', function() gs.nav_hunk("prev") end,     km_priority, bufnr)
          p.addCall('vcs.hunk_next',     function() gs.nav_hunk("next") end,     km_priority, bufnr)
          p.addCall('vcs.hunk_last',     function() gs.nav_hunk("last") end,     km_priority, bufnr)

          p.addCall('vcs.hunk_stage',       function() gs.stage_hunk() end,                                       km_priority, bufnr)
          p.addCall('vcs.hunk_stage_lines', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, km_priority, bufnr)
          p.addCall('vcs.hunk_stage_undo',  function() gs.undo_stage_hunk() end,                                  km_priority, bufnr)

          p.addCall('vcs.buffer_stage', function() gs.stage_buffer() end, km_priority, bufnr)
          p.addCall('vcs.buffer_reset', function() gs.reset_buffer() end, km_priority, bufnr)

          p.addCall('vcs.hunk_reset',       function() gs.reset_hunk() end,                                    km_priority, bufnr)
          p.addCall('vcs.hunk_reset_lines', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, km_priority, bufnr)

          p.addCall('vcs.hunk_preview',      function() gs.preview_hunk() end,              km_priority, bufnr)
          p.addCall('vcs.hunk_blame',        function() gs.blame_line{full=true} end,       km_priority, bufnr)
          p.addCall('vcs.toggle_blame_line', function() gs.toggle_current_line_blame() end, km_priority, bufnr)
          p.addCall('vcs.diff',              function() gs.diffthis() end,                  km_priority, bufnr)
          p.addCall('vcs.diff_head',         function() gs.diffthis('~') end,               km_priority, bufnr)
          p.addCall('vcs.show_deleted',      function() gs.toggle_deleted() end,            km_priority, bufnr)

          -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      },
    },
  },
}
