local p = require('warpcode.utils.keymap-actions')

return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true

      -- empty setup using defaults
      require('nvim-tree').setup()

      p.addCall('fs.file_tree', function()
        vim.cmd('NvimTreeToggle')
      end, 10)
      p.addCall('fs.find_buffer', function()
        vim.cmd('NvimTreeFindFile')
      end, 10)

      -- OR setup with some options
      -- require('nvim-tree').setup({
      --   sort = {
      --     sorter = 'case_sensitive',
      --   },
      --   view = {
      --     width = 30,
      --   },
      --   renderer = {
      --     group_empty = true,
      --   },
      --   filters = {
      --     dotfiles = true,
      --   },
      -- })
    end,
  },
}
