return {
  setup = function()
    -- Load in plugins if available
    pcall(function()
      vim.cmd [[ packadd packer.nvim ]]
      require 'packer'.init {
        display = {
          open_fn = function()
            return require "packer.util".float { border = 'rounded' }
          end,
        }
      }

      return require 'packer'.startup(function(use)
        -- Allow packer to manage itself
        use 'wbthomason/packer.nvim'

      end)
    end)
    require('warpcode.globals')
    -- require('warpcode.projects')

    local group = vim.api.nvim_create_augroup('TEST_AUTOCMD', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      callback = function()
        require 'warpcode.commands'.register(0, 'TEST', {
          run = function() print("test") end,
          children = {
            this = {
              run = function() return {} end,
            },
            is = {
              run = function() return {} end,
              children = {
                aaaaa = {
                  run = function() return {} end,
                },
              },
            },
            are = function()
              return {
                run = function() return {} end,
                children = {
                  aaaaa = {
                    run = function() return {} end,
                    children = function()
                      return {
                        test = {
                          run = function(...) print(vim.inspect({ ... })) end,
                        },
                      }
                    end,
                    params = { 'wat', 'the', 'fuck' }
                  },
                },
              }
            end,
            fail = function()
              return {
              }
            end,
            object = {
              children = {
                one = {
                },
                two = {
                },
                three = {
                },
              },
            },
          }
        })
      end,
      group = group
    })
  end,
}
