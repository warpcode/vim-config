describe('warpcode.keymaps', function()
  local find_keymap = function(lhs)
    for _, map in ipairs(vim.api.nvim_get_keymap('n')) do
      if map.lhs == lhs then
        return map
      end
    end
    return nil
  end

  before_each(function()
    require('warpcode.keymaps')
  end)

  after_each(function()
    vim.cmd('silent! cclose')
    vim.cmd('silent! lclose')
  end)

  describe('quickfix toggle (<leader>qt)', function()
    it('is registered as a normal mode keymap', function()
      local map = find_keymap('\\qt')
      assert.is_not_nil(map)
      assert.is_function(map.callback)
    end)

    it('toggles quickfix window open and closed', function()
      local map = find_keymap('\\qt')
      assert.is_not_nil(map)

      -- Populate quickfix list so copen succeeds
      vim.fn.setqflist({ { filename = 'test.txt', lnum = 1, text = 'qf entry' } })

      -- Initially closed
      assert.are.same(0, vim.fn.getqflist({ winid = 0 }).winid)

      -- First toggle: opens quickfix
      map.callback()
      assert.is_true(vim.fn.getqflist({ winid = 0 }).winid ~= 0)

      -- Second toggle: closes quickfix
      map.callback()
      assert.are.same(0, vim.fn.getqflist({ winid = 0 }).winid)
    end)
  end)

  describe('loclist toggle (<leader>lt)', function()
    it('is registered as a normal mode keymap', function()
      local map = find_keymap('\\lt')
      assert.is_not_nil(map)
      assert.is_function(map.callback)
    end)

    it('toggles loclist window open and closed', function()
      local map = find_keymap('\\lt')
      assert.is_not_nil(map)

      -- Populate location list for current window (0)
      vim.fn.setloclist(0, { { filename = 'test.txt', lnum = 1, text = 'loc entry' } })

      -- Initially closed
      assert.are.same(0, vim.fn.getloclist(0, { winid = 0 }).winid)

      -- First toggle: opens loclist
      map.callback()
      assert.is_true(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0)

      -- Second toggle: closes loclist
      map.callback()
      assert.are.same(0, vim.fn.getloclist(0, { winid = 0 }).winid)
    end)
  end)
end)
