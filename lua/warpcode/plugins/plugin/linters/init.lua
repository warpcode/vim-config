local servers = require('warpcode.plugins.plugin.linters.servers')

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = servers.servers

    -- Update args of specified tools
    for i, x in pairs(servers.args_override) do
      require('lint').linters[i].args = x
    end

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('warpcode-lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint(nil, {
          ignore_errors = true,
        })
      end,
    })
  end,
}
