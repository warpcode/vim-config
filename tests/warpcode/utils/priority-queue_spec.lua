-- Initialize global mock vim table for pure Lua / busted environments
if not _G.vim then
  _G.vim = {
    api = {},
  }
end

describe('warpcode.utils.priority-queue', function()
  local PQueue
  local original_buf_is_loaded

  before_each(function()
    package.loaded['warpcode.utils.priority-queue'] = nil
    PQueue = require('warpcode.utils.priority-queue')
    original_buf_is_loaded = vim.api and vim.api.nvim_buf_is_loaded
  end)

  after_each(function()
    if vim.api and original_buf_is_loaded then
      vim.api.nvim_buf_is_loaded = original_buf_is_loaded
    end
  end)

  it('can be instantiated', function()
    local pq = PQueue:create()
    assert.is_not_nil(pq)
    assert.are.same({}, pq.queue)
  end)

  it('filters out dead buffers and keeps valid or nil buffers', function()
    local pq = PQueue:create()
    local loaded_bufs = { [1] = true, [2] = false, [3] = true }
    vim.api.nvim_buf_is_loaded = function(b)
      return loaded_bufs[b] or false
    end

    pq:add(10, 1, 'id1')
    pq:add(20, 2, 'id2')
    pq:add(30, nil, 'id3')
    pq:add(5, 3, 'id4')

    pq:filterInvalidBuffers()

    assert.are.same(3, #pq.queue)
    -- Check order by priority: 30 (nil buf), 10 (buf 1), 5 (buf 3)
    assert.are.same('id3', pq.queue[1].uniqid)
    assert.are.same('id1', pq.queue[2].uniqid)
    assert.are.same('id4', pq.queue[3].uniqid)
  end)

  it('caches nvim_buf_is_loaded calls per unique buffer id during filter pass', function()
    local pq = PQueue:create()
    local call_counts = {}
    vim.api.nvim_buf_is_loaded = function(b)
      call_counts[b] = (call_counts[b] or 0) + 1
      return true
    end

    -- Add multiple items for buffer 1 and buffer 2
    pq:add(10, 1, 'id1')
    pq:add(20, 1, 'id2')
    pq:add(30, 2, 'id3')
    pq:add(40, 2, 'id4')
    pq:add(50, nil, 'id5')

    pq:filterInvalidBuffers()

    assert.are.same(1, call_counts[1])
    assert.are.same(1, call_counts[2])
    assert.is_nil(call_counts[nil])
    assert.are.same(5, #pq.queue)
  end)

  it('getItems returns items matching buffer or nil buffer', function()
    local pq = PQueue:create()
    vim.api.nvim_buf_is_loaded = function()
      return true
    end

    pq:add(10, 1, 'b1')
    pq:add(20, 2, 'b2')
    pq:add(30, nil, 'global')

    local items_for_1 = pq:getItems(1)
    assert.are.same(2, #items_for_1)
    assert.are.same('global', items_for_1[1].uniqid)
    assert.are.same('b1', items_for_1[2].uniqid)

    local first_item = pq:getFirstItem(1)
    assert.is_not_nil(first_item)
    assert.are.same('global', first_item.uniqid)
  end)
end)
