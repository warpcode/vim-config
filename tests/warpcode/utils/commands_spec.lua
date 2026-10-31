local commands = require('warpcode.utils.commands')

describe('warpcode.utils.commands', function()
  describe('M.run', function()
    it('runs a simple top-level command without arguments', function()
      local executed = false
      local passed_args = nil
      local passed_remaining = nil

      local config = {
        run = function(args, remaining)
          executed = true
          passed_args = args
          passed_remaining = remaining
        end,
      }

      commands.run({ args = '' }, config)

      assert.is_true(executed)
      assert.are.same('', passed_args.args)
      assert.are.same({ '' }, passed_remaining)
    end)

    it('runs a simple top-level command with remaining arguments', function()
      local executed = false
      local passed_remaining = nil

      local config = {
        run = function(_, remaining)
          executed = true
          passed_remaining = remaining
        end,
      }

      commands.run({ args = 'foo bar' }, config)

      assert.is_true(executed)
      assert.are.same({ 'foo', 'bar' }, passed_remaining)
    end)

    it('runs a nested subcommand hierarchy', function()
      local executed = false
      local passed_remaining = nil

      local config = {
        children = {
          project = {
            children = {
              build = {
                run = function(_, remaining)
                  executed = true
                  passed_remaining = remaining
                end,
              },
            },
          },
        },
      }

      commands.run({ args = 'project build --release target' }, config)

      assert.is_true(executed)
      assert.are.same({ '--release', 'target' }, passed_remaining)
    end)

    it('resolves children defined as a function dynamically', function()
      local executed = false
      local dynamic_called_with = nil

      local config = {
        children = function(ctx)
          dynamic_called_with = ctx
          return {
            sub = {
              run = function()
                executed = true
              end,
            },
          }
        end,
      }

      commands.run({ args = 'sub' }, config)

      assert.is_true(executed)
      assert.is_not_nil(dynamic_called_with)
      assert.are.same({ 'sub' }, dynamic_called_with.remaining_args)
    end)

    it('resolves root config passed as a function', function()
      local executed = false

      local config_fn = function()
        return {
          run = function()
            executed = true
          end,
        }
      end

      commands.run({ args = '' }, config_fn)

      assert.is_true(executed)
    end)

    it('throws an error if command_config is not a table', function()
      local config = {
        children = {
          child = 'invalid_config',
        },
      }

      assert.has_error(function()
        commands.run({ args = 'child' }, config)
      end, 'Command cannot be ran')
    end)

    it('throws an error if command config has no run function and no children', function()
      local config = {}

      assert.has_error(function()
        commands.run({ args = '' }, config)
      end, 'Command cannot be ran')
    end)

    it('throws an error if more parameters required when run is missing but children exist', function()
      local config = {
        children = {
          child1 = {
            run = function() end,
          },
        },
      }

      assert.has_error(function()
        commands.run({ args = '' }, config)
      end, 'More parameters required')
    end)
  end)

  describe('M.complete', function()
    it('returns empty table if command_config is not a table', function()
      local completions = commands.complete('arg', 'MyCmd ', 6, nil)
      assert.are.same({}, completions)
    end)

    it('returns child commands when remaining_args is empty', function()
      local config = {
        children = {
          init = { run = function() end },
          test = { run = function() end },
        },
      }

      -- Line is 'MyCmd ' where first word (command name) is stripped
      local completions = commands.complete('', 'MyCmd ', 6, config)
      table.sort(completions)

      assert.are.same({ 'init', 'test' }, completions)
    end)

    it('returns nested child commands when traversing hierarchy', function()
      local config = {
        children = {
          sub = {
            children = {
              deep1 = { run = function() end },
              deep2 = { run = function() end },
            },
          },
        },
      }

      local completions = commands.complete('', 'MyCmd sub ', 10, config)
      table.sort(completions)

      assert.are.same({ 'deep1', 'deep2' }, completions)
    end)

    it('returns params completions when remaining_args is not empty', function()
      local config = {
        children = {
          deploy = {
            run = function() end,
            params = { '--prod', '--staging', '--dry-run' },
          },
        },
      }

      local completions = commands.complete('', 'MyCmd deploy ', 13, config)
      table.sort(completions)

      assert.are.same({ '--dry-run', '--prod', '--staging' }, completions)
    end)

    it('filters out parameters already present in remaining_args', function()
      local config = {
        children = {
          deploy = {
            run = function() end,
            params = { '--prod', '--staging', '--verbose' },
          },
        },
      }

      local completions = commands.complete('', 'MyCmd deploy --prod ', 20, config)
      table.sort(completions)

      assert.are.same({ '--staging', '--verbose' }, completions)
    end)

    it('evaluates dynamic params function for completions', function()
      local config = {
        children = {
          view = {
            run = function() end,
            params = function(ctx)
              if vim.tbl_contains(ctx.remaining_args, 'special') then
                return { 'optionA', 'optionB' }
              end
              return { 'normal1', 'normal2' }
            end,
          },
        },
      }

      local comp1 = commands.complete('', 'MyCmd view ', 11, config)
      table.sort(comp1)
      assert.are.same({ 'normal1', 'normal2' }, comp1)

      local comp2 = commands.complete('', 'MyCmd view special ', 19, config)
      table.sort(comp2)
      assert.are.same({ 'optionA', 'optionB' }, comp2)
    end)
  end)

  describe('M.register and M.deregister', function()
    local bufnr

    before_each(function()
      bufnr = vim.api.nvim_create_buf(false, true)
    end)

    after_each(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end)

    it('ignores registration when command name is empty or nil', function()
      commands.register(bufnr, '', {})
      commands.register(bufnr, nil, {})

      local commands_list = vim.api.nvim_buf_get_commands(bufnr, {})
      assert.is_nil(commands_list[''])
    end)

    it('ignores deregistration when command name is empty or nil', function()
      commands.deregister(bufnr, '')
      commands.deregister(bufnr, nil)
    end)

    it('successfully registers and executes a buffer user command', function()
      local executed = false
      local config = {
        run = function()
          executed = true
        end,
      }

      commands.register(bufnr, 'TestCommand', config)

      local buf_commands = vim.api.nvim_buf_get_commands(bufnr, {})
      assert.is_not_nil(buf_commands['TestCommand'])

      -- Execute command in buffer context
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd('TestCommand')
      end)

      assert.is_true(executed)
    end)

    it('registers command with working completion function', function()
      local config = {
        children = {
          first = { run = function() end },
          second = { run = function() end },
        },
      }

      commands.register(bufnr, 'CompleteCommand', config)

      local buf_commands = vim.api.nvim_buf_get_commands(bufnr, {})
      assert.is_not_nil(buf_commands['CompleteCommand'])

      -- In nvim user commands, complete callback can be retrieved or tested directly via M.complete
      local comp = commands.complete('', 'CompleteCommand ', 16, config)
      table.sort(comp)
      assert.are.same({ 'first', 'second' }, comp)
    end)

    it('deregisters an existing buffer user command cleanly', function()
      local config = {
        run = function() end,
      }

      commands.register(bufnr, 'DeregCommand', config)

      local buf_commands = vim.api.nvim_buf_get_commands(bufnr, {})
      assert.is_not_nil(buf_commands['DeregCommand'])

      commands.deregister(bufnr, 'DeregCommand')

      buf_commands = vim.api.nvim_buf_get_commands(bufnr, {})
      assert.is_nil(buf_commands['DeregCommand'])
    end)
  end)
end)
