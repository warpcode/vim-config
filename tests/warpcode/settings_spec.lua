local assert = require('luassert')

describe('warpcode.settings', function()
  before_each(function()
    package.loaded['warpcode.settings'] = nil
    require('warpcode.settings')
  end)

  it('sets leader keys to space', function()
    assert.are.same(' ', vim.g.mapleader)
    assert.are.same(' ', vim.g.maplocalleader)
  end)

  it('disables backup', function()
    assert.is_false(vim.o.backup)
  end)

  it('configures clipboard to unnamedplus', function()
    assert.are.same('unnamedplus', vim.o.clipboard)
  end)

  it('configures split behavior', function()
    assert.is_true(vim.o.splitright)
    assert.is_true(vim.o.splitbelow)
  end)

  it('configures search behavior', function()
    assert.is_true(vim.o.ignorecase)
    assert.is_true(vim.o.smartcase)
    assert.is_true(vim.o.hlsearch)
    assert.is_true(vim.o.incsearch)
  end)

  it('configures undo options', function()
    assert.is_true(vim.o.undofile)
    assert.are.same(10000, vim.o.history)
    assert.are.same(1000, vim.o.undolevels)
  end)

  it('configures diagnostic format correctly', function()
    local diagnostics_config = vim.diagnostic.config()
    assert.is_function(diagnostics_config.float.format)
    assert.is_function(diagnostics_config.virtual_text.format)

    local diagnostic_mock = { source = 'Test', message = 'Error message' }
    local expected = '[Test] Error message'

    assert.are.same(expected, diagnostics_config.float.format(diagnostic_mock))
    assert.are.same(expected, diagnostics_config.virtual_text.format(diagnostic_mock))
  end)
end)
