local config = require('warpcode.lsp.config')
local path = require('warpcode.utils.path')
require "lspconfig".ansiblels.setup(config.common({
    settings = {
        ansible = {
            python = {
                interpreterPath = path.find_exe_path('python3') or path.find_exe_path('python'),
            },
            ansibleLint = {
                path = 'ansible-lint',
                enabled = true,
            },
            ansible = {
                path = 'ansible',
            },
            executionEnvironment = {
                enabled = false,
            },
        },
    },
}))
