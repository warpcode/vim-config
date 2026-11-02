-- Initialize global mock vim table for pure Lua / busted environments
if not _G.vim then
  _G.vim = {
    api = {},
  }
end

describe('warpcode.utils.priority-queue', function()
  local PQueue
  local original_buf_is_loaded
  local loaded_buffers

  before_each(function()
    package.loaded['warpcode.utils.priority-queue'] = nil
    PQueue = require('warpcode.utils.priority-queue')

    loaded_buffers = { [1] = true, [2] = true }
    original_buf_is_loaded = vim.api and vim.api.nvim_buf_is_loaded
    vim.api.nvim_buf_is_loaded = function(bufnr)
      return loaded_buffers[bufnr] == true
    end
  end)

  after_each(function()
    if original_buf_is_loaded then
      vim.api.nvim_buf_is_loaded = original_buf_is_loaded
    end
  end)

  it('can create a new priority queue', function()
    local pq = PQueue:create()
    assert.is_not_nil(pq)
    assert.are.same({}, pq.queue)
  end)

  describe('add and sortList', function()
    it('adds items with default priority and data', function()
      local pq = PQueue:create()
      pq:add(nil, 1)

      assert.are.same(1, #pq.queue)
      assert.are.same(0, pq.queue[1].priority)
      assert.are.same(1, pq.queue[1].buffer)
      assert.are.same({}, pq.queue[1].data)
    end)

    it('sorts queue in descending order of priority', function()
      local pq = PQueue:create()
      pq:add(10, 1)
      pq:add(50, 1)
      pq:add(25, 1)

      assert.are.same(3, #pq.queue)
      assert.are.same(50, pq.queue[1].priority)
      assert.are.same(25, pq.queue[2].priority)
      assert.are.same(10, pq.queue[3].priority)
    end)

    it('updates existing item if matching buffer and uniqid', function()
      local pq = PQueue:create()
      pq:add(10, 1, 'action_id', { tag = 'v1' })
      assert.are.same(1, #pq.queue)
      assert.are.same(10, pq.queue[1].priority)
      assert.are.same({ tag = 'v1' }, pq.queue[1].data)

      pq:add(90, 1, 'action_id', { tag = 'v2' })
      assert.are.same(1, #pq.queue)
      assert.are.same(90, pq.queue[1].priority)
      assert.are.same({ tag = 'v2' }, pq.queue[1].data)
    end)

    it('does not overwrite item with same uniqid on different buffer', function()
      local pq = PQueue:create()
      pq:add(10, 1, 'shared_id', { buf = 1 })
      pq:add(20, 2, 'shared_id', { buf = 2 })

      assert.are.same(2, #pq.queue)
      assert.are.same(20, pq.queue[1].priority)
      assert.are.same(10, pq.queue[2].priority)
    end)
  end)

  describe('getItems and getFirstItem', function()
    it('returns empty table when queue is empty', function()
      local pq = PQueue:create()
      local items = pq:getItems(1)
      assert.are.same({}, items)
      assert.is_nil(pq:getFirstItem(1))
    end)

    it('returns global items and buffer-specific items matching target buffer', function()
      local pq = PQueue:create()
      pq:add(100, nil, 'global_action')
      pq:add(50, 1, 'buf1_action')
      pq:add(80, 2, 'buf2_action')

      local items_buf1 = pq:getItems(1)
      assert.are.same(2, #items_buf1)
      assert.are.same('global_action', items_buf1[1].uniqid)
      assert.are.same('buf1_action', items_buf1[2].uniqid)

      local first_buf1 = pq:getFirstItem(1)
      assert.is_not_nil(first_buf1)
      assert.are.same('global_action', first_buf1.uniqid)

      local items_buf2 = pq:getItems(2)
      assert.are.same(2, #items_buf2)
      assert.are.same('global_action', items_buf2[1].uniqid)
      assert.are.same('buf2_action', items_buf2[2].uniqid)
    end)

    it('filters out dead buffers automatically', function()
      local pq = PQueue:create()
      pq:add(50, 1, 'buf1_action')
      pq:add(40, 2, 'buf2_action')

      -- Mark buffer 2 as unloaded / dead
      loaded_buffers[2] = false

      local items = pq:getItems(1)
      assert.are.same(1, #items)
      assert.are.same('buf1_action', items[1].uniqid)

      -- Queue itself has been cleaned of dead buffer 2
      assert.are.same(1, #pq.queue)
    end)
  end)
end)
