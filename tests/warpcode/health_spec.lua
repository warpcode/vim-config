local health = require('warpcode.health')
local match = require('luassert.match')
local stub = require('luassert.stub')

describe('warpcode.health', function()
  local start_stub, ok_stub, warn_stub, error_stub, info_stub, has_stub, executable_stub

  before_each(function()
    start_stub = stub(vim.health, 'start')
    ok_stub = stub(vim.health, 'ok')
    warn_stub = stub(vim.health, 'warn')
    error_stub = stub(vim.health, 'error')
    info_stub = stub(vim.health, 'info')
    has_stub = stub(vim.fn, 'has')
    executable_stub = stub(vim.fn, 'executable')

    -- Mock require using package.loaded trick for core modules
    package.loaded['warpcode.utils.terminal'] = {}
    package.loaded['warpcode.utils.commands'] = {}
    package.loaded['warpcode.utils.priority-queue'] = {}
    package.loaded['warpcode.utils.keymap-actions'] = {}
    package.loaded['warpcode.settings'] = {}
    package.loaded['warpcode.keymaps'] = {}
  end)

  after_each(function()
    start_stub:revert()
    ok_stub:revert()
    warn_stub:revert()
    error_stub:revert()
    info_stub:revert()
    has_stub:revert()
    executable_stub:revert()

    package.loaded['warpcode.utils.terminal'] = nil
    package.loaded['warpcode.utils.commands'] = nil
    package.loaded['warpcode.utils.priority-queue'] = nil
    package.loaded['warpcode.utils.keymap-actions'] = nil
    package.loaded['warpcode.settings'] = nil
    package.loaded['warpcode.keymaps'] = nil
  end)

  it('reports all ok when requirements are met', function()
    has_stub.returns(1)
    executable_stub.returns(1)

    health.check()

    assert.stub(start_stub).was_called_with('warpcode')
    assert.stub(info_stub).was_called_with('Checking Neovim version')
    assert.stub(ok_stub).was_called_with('Neovim version is 0.9.0 or newer')

    assert.stub(info_stub).was_called_with('Checking external tools')
    assert.stub(ok_stub).was_called_with('git is installed')
    assert.stub(ok_stub).was_called_with('rg is installed')
    assert.stub(ok_stub).was_called_with('fd is installed')
    assert.stub(ok_stub).was_called_with('lazygit is installed')

    assert.stub(info_stub).was_called_with('Checking warpcode core modules')
    assert.stub(ok_stub).was_called_with('Module warpcode.utils.terminal loaded successfully')
    assert.stub(ok_stub).was_called_with('Module warpcode.utils.commands loaded successfully')
    assert.stub(ok_stub).was_called_with('Module warpcode.utils.priority-queue loaded successfully')
    assert.stub(ok_stub).was_called_with('Module warpcode.utils.keymap-actions loaded successfully')
    assert.stub(ok_stub).was_called_with('Module warpcode.settings loaded successfully')
    assert.stub(ok_stub).was_called_with('Module warpcode.keymaps loaded successfully')

    assert.stub(error_stub).was_not_called()
    assert.stub(warn_stub).was_not_called()
  end)

  it('reports error when neovim version is too old', function()
    has_stub.returns(0)
    executable_stub.returns(1)

    health.check()

    assert.stub(error_stub).was_called_with('Neovim version must be at least 0.9.0')
  end)

  it('reports warnings when external tools are missing', function()
    has_stub.returns(1)
    executable_stub.invokes(function(tool)
      if tool == 'git' or tool == 'rg' then return 1 else return 0 end
    end)

    health.check()

    assert.stub(warn_stub).was_called_with('fd is not installed')
    assert.stub(warn_stub).was_called_with('lazygit is not installed')
    assert.stub(ok_stub).was_called_with('git is installed')
    assert.stub(ok_stub).was_called_with('rg is installed')
  end)

  it('reports errors when core modules fail to load', function()
    has_stub.returns(1)
    executable_stub.returns(1)

    package.loaded['warpcode.utils.terminal'] = nil
    package.loaded['warpcode.utils.commands'] = nil

    -- Mock require to fail for specific modules
    local old_require = require
    _G.require = function(mod)
      if mod == 'warpcode.utils.terminal' or mod == 'warpcode.utils.commands' then
        error("Module failed to load")
      end
      return old_require(mod)
    end

    health.check()

    _G.require = old_require

    assert.stub(error_stub).was_called_with('Module warpcode.utils.terminal failed to load')
    assert.stub(error_stub).was_called_with('Module warpcode.utils.commands failed to load')
    assert.stub(ok_stub).was_called_with('Module warpcode.utils.priority-queue loaded successfully')
  end)
end)
