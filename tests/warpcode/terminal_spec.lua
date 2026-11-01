local terminal = require('warpcode.utils.terminal')

local function get_coord(val)
  if type(val) == 'table' then
    return val[false]
  end
  return val
end

describe('warpcode.utils.terminal', function()
  before_each(function()
    -- Save and reset terminal state before each test
    terminal.state.floating.buf = -1
    terminal.state.floating.win = -1
  end)

  after_each(function()
    -- Clean up any opened windows or buffers
    if terminal.state.floating.win and vim.api.nvim_win_is_valid(terminal.state.floating.win) then
      pcall(vim.api.nvim_win_close, terminal.state.floating.win, true)
    end
    if terminal.state.floating.buf and vim.api.nvim_buf_is_valid(terminal.state.floating.buf) then
      pcall(vim.api.nvim_buf_delete, terminal.state.floating.buf, { force = true })
    end
  end)

  describe('create_floating_window', function()
    it('creates a valid floating window and buffer with default dimensions', function()
      local res = terminal.create_floating_window()

      assert.is_not_nil(res)
      assert.is_true(vim.api.nvim_buf_is_valid(res.buf))
      assert.is_true(vim.api.nvim_win_is_valid(res.win))

      local expected_width = math.floor(vim.o.columns * 0.8)
      local expected_height = math.floor(vim.o.lines * 0.8)
      local expected_col = math.floor((vim.o.columns - expected_width) / 2)
      local expected_row = math.floor((vim.o.lines - expected_height) / 2)

      local config = vim.api.nvim_win_get_config(res.win)
      assert.are.same(expected_width, config.width)
      assert.are.same(expected_height, config.height)
      assert.are.same(expected_col, get_coord(config.col))
      assert.are.same(expected_row, get_coord(config.row))
      assert.are.same('editor', config.relative)

      -- Clean up created window and buffer
      vim.api.nvim_win_close(res.win, true)
      vim.api.nvim_buf_delete(res.buf, { force = true })
    end)

    it('creates a floating window with custom width and height', function()
      local custom_w = 40
      local custom_h = 15
      local res = terminal.create_floating_window({ width = custom_w, height = custom_h })

      assert.is_true(vim.api.nvim_win_is_valid(res.win))
      local config = vim.api.nvim_win_get_config(res.win)
      assert.are.same(custom_w, config.width)
      assert.are.same(custom_h, config.height)

      local expected_col = math.floor((vim.o.columns - custom_w) / 2)
      local expected_row = math.floor((vim.o.lines - custom_h) / 2)
      assert.are.same(expected_col, get_coord(config.col))
      assert.are.same(expected_row, get_coord(config.row))

      vim.api.nvim_win_close(res.win, true)
      vim.api.nvim_buf_delete(res.buf, { force = true })
    end)

    it('reuses existing buffer if a valid buffer id is passed in opts.buf', function()
      local existing_buf = vim.api.nvim_create_buf(false, true)
      local res = terminal.create_floating_window({ buf = existing_buf })

      assert.are.same(existing_buf, res.buf)
      assert.are.same(existing_buf, vim.api.nvim_win_get_buf(res.win))

      vim.api.nvim_win_close(res.win, true)
      vim.api.nvim_buf_delete(existing_buf, { force = true })
    end)

    it('creates a new buffer if invalid buffer id is passed in opts.buf', function()
      local invalid_buf = 99999
      local res = terminal.create_floating_window({ buf = invalid_buf })

      assert.is_true(res.buf ~= invalid_buf)
      assert.is_true(vim.api.nvim_buf_is_valid(res.buf))

      vim.api.nvim_win_close(res.win, true)
      vim.api.nvim_buf_delete(res.buf, { force = true })
    end)
  end)

  describe('toggle_terminal', function()
    it('opens terminal floating window on first toggle', function()
      assert.is_false(vim.api.nvim_win_is_valid(terminal.state.floating.win))

      terminal.toggle_terminal()

      assert.is_true(vim.api.nvim_win_is_valid(terminal.state.floating.win))
      assert.is_true(vim.api.nvim_buf_is_valid(terminal.state.floating.buf))
      assert.are.same('terminal', vim.bo[terminal.state.floating.buf].buftype)
    end)

    it('hides window on second toggle', function()
      terminal.toggle_terminal()
      local win = terminal.state.floating.win
      local buf = terminal.state.floating.buf

      assert.is_true(vim.api.nvim_win_is_valid(win))

      terminal.toggle_terminal()

      assert.is_false(vim.api.nvim_win_is_valid(win))
      -- Buffer should still remain valid in memory
      assert.is_true(vim.api.nvim_buf_is_valid(buf))
    end)

    it('re-opens existing terminal buffer on third toggle without creating new buffer', function()
      terminal.toggle_terminal()
      local original_buf = terminal.state.floating.buf
      assert.is_true(vim.api.nvim_win_is_valid(terminal.state.floating.win))

      -- Second toggle hides it
      terminal.toggle_terminal()
      assert.is_false(vim.api.nvim_win_is_valid(terminal.state.floating.win))

      -- Third toggle re-opens it
      terminal.toggle_terminal()
      assert.is_true(vim.api.nvim_win_is_valid(terminal.state.floating.win))
      assert.are.same(original_buf, terminal.state.floating.buf)
      assert.are.same(original_buf, vim.api.nvim_win_get_buf(terminal.state.floating.win))
    end)

    it('re-creates buffer if previous buffer was wiped out or invalidated', function()
      terminal.toggle_terminal()
      local first_buf = terminal.state.floating.buf
      local first_win = terminal.state.floating.win

      -- Hide window
      terminal.toggle_terminal()
      assert.is_false(vim.api.nvim_win_is_valid(first_win))

      -- Wipe out buffer
      vim.api.nvim_buf_delete(first_buf, { force = true })
      assert.is_false(vim.api.nvim_buf_is_valid(first_buf))

      -- Next toggle should detect invalid buffer and create a new terminal buffer
      terminal.toggle_terminal()
      assert.is_true(vim.api.nvim_win_is_valid(terminal.state.floating.win))
      assert.is_true(vim.api.nvim_buf_is_valid(terminal.state.floating.buf))
      assert.is_true(terminal.state.floating.buf ~= first_buf)
      assert.are.same('terminal', vim.bo[terminal.state.floating.buf].buftype)
    end)
  end)
end)
