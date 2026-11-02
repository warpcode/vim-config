-- Initialize global mock vim table for pure Lua / busted environments
if not _G.vim then
  _G.vim = {
    api = {},
    log = { levels = { WARN = 2 } },
  }
end

describe('warpcode.utils.priority-queue', function()
  local PQueue
  local original_buf_is_loaded

  before_each(function()
    package.loaded['warpcode.utils.priority-queue'] = nil
    PQueue = require('warpcode.utils.priority-queue')

    original_buf_is_loaded = vim.api and vim.api.nvim_buf_is_loaded
    vim.api.nvim_buf_is_loaded = function(bufnr)
      return bufnr ~= 999
    end
  end)

  after_each(function()
    if original_buf_is_loaded then
      vim.api.nvim_buf_is_loaded = original_buf_is_loaded
    end
  end)

  it('can be instantiated', function()
    local pq = PQueue:create()
    assert.is_not_nil(pq)
    assert.are.same({}, pq.queue)
  end)

  it('inserts items in descending priority order', function()
    local pq = PQueue:create()
    pq:add(10, 1, 'item1', { name = 'ten' })
    pq:add(50, 1, 'item2', { name = 'fifty' })
    pq:add(30, 1, 'item3', { name = 'thirty' })
    pq:add(5, 1, 'item4', { name = 'five' })
    pq:add(30, 1, 'item5', { name = 'thirty_b' })

    assert.are.same(5, #pq.queue)
    assert.are.same(50, pq.queue[1].priority)
    assert.are.same(30, pq.queue[2].priority)
    assert.are.same(30, pq.queue[3].priority)
    assert.are.same(10, pq.queue[4].priority)
    assert.are.same(5, pq.queue[5].priority)
  end)

  it('updates existing item data when uniqid and buffer match with same priority', function()
    local pq = PQueue:create()
    pq:add(20, 1, 'id_1', { count = 1 })
    pq:add(30, 1, 'id_2', { count = 2 })

    pq:add(20, 1, 'id_1', { count = 100 })

    assert.are.same(2, #pq.queue)
    assert.are.same('id_2', pq.queue[1].uniqid)
    assert.are.same('id_1', pq.queue[2].uniqid)
    assert.are.same(100, pq.queue[2].data.count)
  end)

  it('updates existing item position when priority changes', function()
    local pq = PQueue:create()
    pq:add(10, 1, 'id_1', { count = 1 })
    pq:add(20, 1, 'id_2', { count = 2 })
    pq:add(30, 1, 'id_3', { count = 3 })

    -- promote id_1 to priority 40
    pq:add(40, 1, 'id_1', { count = 99 })

    assert.are.same(3, #pq.queue)
    assert.are.same('id_1', pq.queue[1].uniqid)
    assert.are.same(40, pq.queue[1].priority)
    assert.are.same(99, pq.queue[1].data.count)
    assert.are.same('id_3', pq.queue[2].uniqid)
    assert.are.same('id_2', pq.queue[3].uniqid)
  end)

  it('filters out invalid buffers and keeps valid/global items', function()
    local pq = PQueue:create()
    pq:add(10, 1, 'buf1', {})
    pq:add(20, 999, 'buf_dead', {}) -- buffer 999 is invalid
    pq:add(30, nil, 'global', {})

    local items = pq:getItems(1)
    assert.are.same(2, #items)
    assert.are.same('global', items[1].uniqid)
    assert.are.same('buf1', items[2].uniqid)

    local first = pq:getFirstItem(1)
    assert.is_not_nil(first)
    assert.are.same('global', first.uniqid)
  end)

  it('returns nil from getFirstItem when empty or no items match buffer', function()
    local pq = PQueue:create()
    assert.is_nil(pq:getFirstItem(1))

    pq:add(10, 2, 'buf2', {})
    assert.is_nil(pq:getFirstItem(1))
  end)
end)
