describe('bootstrap lazy.nvim', function()
  it('should exit when git clone fails', function()
    -- We can intercept the system call
    local old_system = vim.fn.system
    local old_exit = os.exit
    local old_fs_stat = vim.loop.fs_stat

    local system_called = false
    local exited = false

    vim.loop.fs_stat = function(path)
      return nil -- simulate lazy.nvim not installed
    end

    vim.fn.system = function(...)
      system_called = true
      return "fatal: some fake git error"
    end

    -- vim.v.shell_error is read-only, so we have to actually do a failing shell call to set it
    -- but if we intercept system, it might not set it. Let's not intercept system entirely,
    -- or let's intercept system and then manually do a failing system call

    -- Wait, if we intercept vim.fn.system, we can't set vim.v.shell_error.
    -- Let's just override vim.v instead? No, it's a special table.
    -- Instead, let's just make the actual vim.fn.system call a failing command!

    vim.fn.system = function(cmd)
      system_called = true
      -- actually do a failing command so vim.v.shell_error gets set
      old_system("false")
      return "fatal: could not read Username"
    end

    os.exit = function(code)
      exited = true
      assert.are.equal(1, code)
    end

    -- intercept echo and getchar so it doesn't hang
    local old_echo = vim.api.nvim_echo
    local old_getchar = vim.fn.getchar

    local echo_called = false
    vim.api.nvim_echo = function(...)
      echo_called = true
    end
    vim.fn.getchar = function(...)
      return 1
    end

    -- Load the file
    -- package.loaded might have it, let's clear it just in case
    package.loaded['warpcode.plugins.bootstrap'] = nil
    require('warpcode.plugins.bootstrap')

    assert.is_true(system_called)
    assert.is_true(echo_called)
    assert.is_true(exited)

    -- restore everything
    vim.fn.system = old_system
    os.exit = old_exit
    vim.loop.fs_stat = old_fs_stat
    vim.api.nvim_echo = old_echo
    vim.fn.getchar = old_getchar
  end)
end)
