local assert = require('luassert')

describe('Formatters configuration', function()
  local conform_setup_opts
  local conform_mock

  before_each(function()
    _G.vim = {
      g = {},
      b = {},
      api = {
        nvim_get_current_buf = function() return 1 end,
        nvim_create_user_command = function(name, callback, opts)
          _G.vim.api.commands = _G.vim.api.commands or {}
          _G.vim.api.commands[name] = callback
        end
      },
      log = { levels = { INFO = 1 } },
      notify = function() end,
      cmd = function(cmd)
        if cmd == 'FormatToggle' then
          _G.vim.api.commands['FormatToggle']({ bang = false })
        elseif cmd == 'FormatToggle!' then
          _G.vim.api.commands['FormatToggle']({ bang = true })
        end
      end
    }

    -- Ensure vim.b[1] exists for tests
    _G.vim.b[1] = {}

    conform_mock = {
      setup = function(opts)
        conform_setup_opts = opts
      end,
      format = function() end,
    }
    package.loaded['conform'] = conform_mock

    package.loaded['warpcode.utils.keymap-actions'] = {
      addCall = function() end
    }
    package.loaded['warpcode.plugins.plugin.formatters.servers'] = {
      servers = {},
      formatters_override = {},
    }

    local formatters = require('warpcode.plugins.plugin.formatters.init')
    formatters.config()
  end)

  after_each(function()
    package.loaded['warpcode.plugins.plugin.formatters.init'] = nil
    package.loaded['conform'] = nil
    package.loaded['warpcode.utils.keymap-actions'] = nil
    package.loaded['warpcode.plugins.plugin.formatters.servers'] = nil
    _G.vim = nil
  end)

  it('sets up format_on_save', function()
    assert.is_not_nil(conform_setup_opts.format_on_save)
    local opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.are.same({ timeout_ms = 5000, lsp_format = 'fallback' }, opts)
  end)

  it('disables format_on_save globally', function()
    vim.cmd('FormatToggle')
    assert.is_true(vim.g.disable_autoformat)
    local opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.is_nil(opts)

    vim.cmd('FormatToggle')
    assert.is_false(vim.g.disable_autoformat)
    opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.are.same({ timeout_ms = 5000, lsp_format = 'fallback' }, opts)
  end)

  it('disables format_on_save buffer-locally', function()
    vim.cmd('FormatToggle!')
    assert.is_true(vim.b.disable_autoformat)
    vim.b[1].disable_autoformat = vim.b.disable_autoformat -- mock syncing b table to buffer id
    local opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.is_nil(opts)

    vim.cmd('FormatToggle!')
    assert.is_false(vim.b.disable_autoformat)
    vim.b[1].disable_autoformat = vim.b.disable_autoformat
    opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.are.same({ timeout_ms = 5000, lsp_format = 'fallback' }, opts)
  end)

  it('buffer local takes precedence over global', function()
    vim.cmd('FormatToggle')
    assert.is_true(vim.g.disable_autoformat)

    vim.cmd('FormatToggle!')
    assert.is_true(vim.b.disable_autoformat)
    vim.b[1].disable_autoformat = vim.b.disable_autoformat

    local opts = conform_setup_opts.format_on_save(vim.api.nvim_get_current_buf())
    assert.is_nil(opts)
  end)
end)
