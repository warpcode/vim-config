return {
    run = function()
        pcall(function()
            dap = require 'dap'

            vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

            vim.keymap.set('n', '<leader>db', function() require"dap".toggle_breakpoint() end)
            vim.keymap.set('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
            vim.keymap.set('n', '<leader>dc', function() require"dap".continue() end)
            vim.keymap.set('n', '<leader>dC', function() require"dap".terminate() end)
            vim.keymap.set('n', '<leader>do', function() require"dap".step_over() end)
            vim.keymap.set('n', "<leader>di", function() require"dap".step_into() end)
            vim.keymap.set('n', '<leader>dI', function() require"dap".step_out() end)
            vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
            vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
            -- vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
            -- vim.keymap.set('n', '<leader>dR', function() require"dap".clear_breakpoints() end)
            -- vim.keymap.set('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
            vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
            vim.keymap.set('n', '<leader>dA', function() require"debugHelper".attachToRemote() end)
            vim.keymap.set('n', '<leader>dh', function() require"dap.ui.widgets".hover() end)
            vim.keymap.set('n', '<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
            vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

            local vscode_debugger_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/vscode-php-debug/out/phpDebug.js'

            if vim.fn.filereadable(vscode_debugger_path) == 1 then
                dap.adapters.php = {
                    type = 'executable',
                    command = 'node',
                    args = { vscode_debugger_path }
                }

                dap.configurations.php = {
                    {
                        name = 'Listen for Martini xdebug',
                        type = 'php',
                        request = 'launch',
                        port = '9003',
                        log = true,
                        pathMappings = {
                            ['/var/www/html/martini-git'] = "${workspaceFolder}",
                        },
                    },
                    {
                        name = 'Listen for xdebug',
                        type = 'php',
                        request = 'launch',
                        port = '9003',
                        log = true
                    },
                    {
                        name = "Launch currently open script",
                        type = "php",
                        request = "launch",
                        program = "${file}",
                        cwd = "${fileDirname}",
                        port = 0,
                        runtimeArgs = {
                            "-dxdebug.start_with_request=yes"
                        },
                        env = {
                            XDEBUG_MODE = "debug,develop",
                            XDEBUG_CONFIG = "client_port=${port}"
                        }
                    },
                    -- {
                    --     name = "Launch Built-in web server",
                    --     type = "php",
                    --     request = "launch",
                    --     runtimeArgs = {
                    --         "-dxdebug.mode=debug",
                    --         "-dxdebug.start_with_request=yes",
                    --         "-S",
                    --         "localhost:0"
                    --     },
                    --     program = "",
                    --     cwd = "${workspaceRoot}",
                    --     port = 9003,
                    --     serverReadyAction = {
                    --         pattern = "Development Server \\(http://localhost:([0-9]+)\\) started",
                    --         uriFormat = "http://localhost:%s",
                    --         action = "openExternally"
                    --     }
                    -- }
                }
            end
        end)
    end
}
