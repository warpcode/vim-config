pcall(function()
    local pexec = require 'warpcode.priority-exec'
    require "lspsaga".setup({})

    -- LSP overrides
    pexec.addCall('lsp.code_action', function () vim.cmd [[ Lspsaga code_action ]]  end, 10)
    pexec.addCall('lsp.rename', function () vim.cmd [[ Lspsaga rename ]]  end, 10)

    -- diagnostics overrides
    pexec.addCall('diagnostics.next', function () require("lspsaga.diagnostic"):goto_next()  end, 10)
    pexec.addCall('diagnostics.prev', function () require("lspsaga.diagnostic"):goto_prev()  end, 10)
    pexec.addCall('diagnostics.buffer', function () vim.cmd [[ Lspsaga show_buf_diagnostics ]]  end, 10)
    pexec.addCall('diagnostics.workspace', function () vim.cmd [[ Lspsaga show_workspace_diagnostics ]]  end, 10)
end)
