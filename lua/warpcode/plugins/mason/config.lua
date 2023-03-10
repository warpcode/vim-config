return {
    run = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "bashls",
                "dockerls",
                "emmet_ls",
                "gopls",
                "html",
                "intelephense",
                "jsonls",
                "lua_ls",
                "rust_analyzer",
                "sqlls",
                "tsserver",
                "vimls",
            },
        })
    end
}
