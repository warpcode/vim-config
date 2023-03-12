return {

    -- { "n", "<leader>ds", vim.diagnostic.open_float },
    { "n", "[d", vim.diagnostic.goto_prev, },
    { "n", "]d", vim.diagnostic.goto_next, },
    { "n", "<leader>dll", function()
        local status = pcall(function()
            require('telescope.builtin').diagnostics({ bufnr = 0, prompt_title = "Current file" })
        end)

        if status then
            return
        end

        vim.diagnostic.setloclist()
    end, },
    { "n", "<leader>dqf", function()
        local status = pcall(function()
            require('telescope.builtin').diagnostics({ prompt_title = "Project" })
        end)

        if status then
            return
        end

        vim.diagnostic.setqflist()
    end, },
}
