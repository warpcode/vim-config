-- Initialize global mock vim table for pure Lua / busted environments
if not _G.vim then
  _G.vim = {
    api = {},
    log = { levels = { WARN = 2 } },
  }
end

describe('warpcode.utils.keymap-actions', function()
  local actions
  local original_notify
  local original_get_current_buf
  local original_buf_is_loaded
  local notifications
  local current_buf

  before_each(function()
    package.loaded['warpcode.utils.keymap-actions'] = nil
    package.loaded['warpcode.utils.priority-queue'] = nil
    actions = require('warpcode.utils.keymap-actions')

    notifications = {}
    current_buf = 1

    original_notify = vim.notify
    original_get_current_buf = vim.api and vim.api.nvim_get_current_buf
    original_buf_is_loaded = vim.api and vim.api.nvim_buf_is_loaded

    vim.notify = function(msg, level)
      table.insert(notifications, { msg = msg, level = level })
    end

    vim.api.nvim_get_current_buf = function()
      return current_buf
    end

    vim.api.nvim_buf_is_loaded = function(bufnr)
      return true
    end
  end)

  after_each(function()
    if original_notify then
      vim.notify = original_notify
    end
    if original_get_current_buf then
      vim.api.nvim_get_current_buf = original_get_current_buf
    end
    if original_buf_is_loaded then
      vim.api.nvim_buf_is_loaded = original_buf_is_loaded
    end
  end)

  it('can be required', function()
    assert.is_not_nil(actions)
  end)

  describe('getAction when action does not exist or has no items', function()
    it('notifies warning when action was never added', function()
      local action_fn = actions.getAction('unregistered.action')
      assert.is_function(action_fn)

      action_fn()

      assert.are.same(1, #notifications)
      assert.are.same('unregistered.action is not imlemented', notifications[1].msg)
      assert.are.same(vim.log.levels.WARN, notifications[1].level)
    end)

    it('notifies warning when action has no items for the current buffer', function()
      -- Action registered only for buffer 2
      actions.addCall('buffer_specific_action', function() end, 10, 2)

      -- Current buffer is 1
      current_buf = 1
      local action_fn = actions.getAction('buffer_specific_action')
      action_fn()

      assert.are.same(1, #notifications)
      assert.are.same('buffer_specific_action is not imlemented', notifications[1].msg)
      assert.are.same(vim.log.levels.WARN, notifications[1].level)
    end)
  end)

  describe('addCall and getAction execution', function()
    it('executes registered function and passes item and args', function()
      local called = false
      local received_item = nil
      local received_args = nil

      local fn = function(item, args)
        called = true
        received_item = item
        received_args = args
        return 'executed'
      end

      actions.addCall('test.run', fn, 5, nil, { meta = 'info' }, 'uniq_1')

      local action_fn = actions.getAction('test.run', { foo = 'bar' })
      local result = action_fn()

      assert.is_true(called)
      assert.are.same('executed', result)
      assert.is_not_nil(received_item)
      assert.are.same(5, received_item.priority)
      assert.are.same('uniq_1', received_item.uniqid)
      assert.are.same({ meta = 'info' }, received_item.data.payload)
      assert.are.same({ foo = 'bar' }, received_args)
      assert.are.same(0, #notifications)
    end)

    it('handles non-function item correctly by returning value or not_impl', function()
      actions.addCall('test.string_val', 'some string command', 5)

      local action_fn = actions.getAction('test.string_val')
      local result = action_fn()

      assert.are.same('some string command', result)
      assert.are.same(0, #notifications)
    end)

    it('returns not_impl when non-function item fn is nil/false', function()
      actions.addCall('test.nil_fn', nil, 5)

      local action_fn = actions.getAction('test.nil_fn')
      action_fn()

      assert.are.same(1, #notifications)
      assert.are.same('test.nil_fn is not imlemented', notifications[1].msg)
    end)
  end)

  describe('priorities and buffer selection', function()
    it('executes higher priority action first', function()
      local execution_order = {}

      actions.addCall('test.priority', function()
        table.insert(execution_order, 'low')
      end, 10)

      actions.addCall('test.priority', function()
        table.insert(execution_order, 'high')
      end, 100)

      actions.addCall('test.priority', function()
        table.insert(execution_order, 'medium')
      end, 50)

      local action_fn = actions.getAction('test.priority')
      action_fn()

      assert.are.same({ 'high' }, execution_order)
    end)

    it('prioritizes buffer-specific actions over global ones when priority allows', function()
      local result = nil

      actions.addCall('test.buf_override', function()
        result = 'global'
      end, 10, nil)

      actions.addCall('test.buf_override', function()
        result = 'buf_2'
      end, 20, 2)

      current_buf = 2
      local action_fn = actions.getAction('test.buf_override')
      action_fn()
      assert.are.same('buf_2', result)

      current_buf = 1
      action_fn()
      assert.are.same('global', result)
    end)

    it('updates existing action when uniqid and buffer match', function()
      local result = nil

      actions.addCall('test.update', function()
        result = 'first'
      end, 10, 1, nil, 'update_id')

      actions.addCall('test.update', function()
        result = 'second'
      end, 10, 1, nil, 'update_id')

      current_buf = 1
      local action_fn = actions.getAction('test.update')
      action_fn()

      assert.are.same('second', result)
    end)
  end)
end)
