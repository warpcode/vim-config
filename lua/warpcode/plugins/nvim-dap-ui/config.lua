local dap_ok, dap = pcall(require, 'dap')
local dapui_ok, dapui = pcall(require, 'dapui')

return {
    run = function()
        if not dapui_ok and not dap_ok then return end

        dapui.setup()

        vim.keymap.set('n', '<leader>du', function() dapui.toggle() end)

        -- Auto open/close
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
