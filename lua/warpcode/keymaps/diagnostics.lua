return {

    { "n", "<leader>ds",  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },
    { "n", "[d",          vim.diagnostic.goto_prev, },
    { "n", "]d",          vim.diagnostic.goto_next, },
    { "n", "<leader>dll", vim.diagnostic.setloclist, },
    { "n", "<leader>dqf", vim.diagnostic.setqflist, },
}
