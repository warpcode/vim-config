pcall(function()
    require("mason-tool-installer").setup({
        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = vim.list_extend(
            { 'php-debug-adapter' },
            vim.list_extend(
                require 'warpcode.lsp.lspconfig'.get_packages(),
                require "warpcode.lsp.null-ls".get_packages()
            )
        ),
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,             -- 3 second delay
        -- debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })
end)
