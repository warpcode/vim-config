local M = {
    source = "neovim/nvim-lspconfig",
    requires = {
        { "onsails/lspkind-nvim" },
        { "tami5/lspsaga.nvim" },
        { "ray-x/lsp_signature.nvim" },
        { "jose-elias-alvarez/null-ls.nvim" },
        { "williamboman/mason.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "jay-babu/mason-null-ls.nvim" },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "bashls",
                "dockerls",
                "emmet_ls",
                -- "gopls",
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
        require("mason-null-ls").setup({
            ensure_installed = {
                -- asciidoc
                "vale",

                -- cmake
                "cmake_format",
                "gersemi",

                -- cpp
                "cpplint",
                "clang_format",

                -- cs
                "clang_format",
                "csharpier",

                -- 'css',
                "prettier",
                "prettierd",

                -- 'dockerfile',
                "hadolint",
                -- git
                "commitlint",
                "gitlint",

                -- html
                "prettier",
                "prettierd",

                -- 'javascript'
                "eslint_d",
                "prettier",
                "prettierd",
                "dprint",
                "rome",
                "xo",

                -- 'json',
                "cfn-lint",
                "jsonlint",
                "dprint",
                "fixjson",
                "jq",
                "prettier",
                "prettierd",

                -- 'lua',
                "luacheck",
                -- "selene",
                "stylua",

                -- markdown
                "alex",
                "markdownlint",
                "proselint",
                "vale",
                "write_good",
                "cbfmt",
                "dprint",
                "prettier",
                "prettierd",

                -- 'php',
                "phpcs",
                "phpmd",
                "phpstan",
                "psalm",
                "phpcbf",
                "phpcsfixer",
                "pint",

                -- 'shell',
                "shellcheck",
                "beautysh",
                "shellharden",
                "shfmt",

                -- 'sql',
                "sql_formatter",
                "sqlfluff",

                -- 'vim',
                "vint",

                -- 'yaml',
                "actionlint",
                "cfn-lint",
                "yamllint",
                "prettier",
                "prettierd",
            },
            automatic_installation = true,
            automatic_setup = true, -- Recommended, but optional
        })

        local null_ls = require("null-ls")
        null_ls.setup({
            debug = false,
            sources = {
                null_ls.builtins.formatting.json_tool,
            },
            on_attach = require("warpcode.plugins.lsp.lspconfig").custom_attach,
            -- diagnostics_format = "[#{s}] #{m} [#{c}]"
        })

        require("mason-null-ls").setup_handlers({
            function(source_name, methods)
                -- all sources with no handler get passed here

                -- To keep the original functionality of `automatic_setup = true`,
                -- please add the below.
                require("mason-null-ls.automatic_setup")(source_name, methods)
            end,
            phpcbf = function(source_name, methods)
                null_ls.register(null_ls.builtins.formatting.phpcbf.with({
                    extra_args = {
                        "--standard=PSR12",
                    },
                }))
            end,
            phpcs = function(source_name, methods)
                null_ls.register(null_ls.builtins.diagnostics.phpcs.with({
                    extra_args = {
                        "--standard=PSR12",
                    },
                }))
            end,
            -- stylua = function(source_name, methods)
            --     null_ls.register(null_ls.builtins.formatting.stylua)
            -- end,
        }) -- If `automatic_setup` is true.

        require("lsp_signature").setup({
            -- bind = false,
            -- floating_window = true,
            -- floating_window_off_x = 1, -- adjust float windows x position.
            -- floating_window_off_y = 1000, -- adjust float windows y position.
            -- hint_enable = true,
            -- -- hi_parameter = "Search",
            -- handler_opts = {
            --     border = "shadow"   -- double, rounded, single, shadow, none
            -- },
            -- fix_pos = function(signatures, _) -- second argument is the client
            --     return signatures.activeParameter >= 0 and #signatures.parameters > 1
            -- end,
        })

        -- require'lspkind'.init({
        --     with_text = true,
        -- })
        --

        -- add your config value here
        -- default value
        -- use_saga_diagnostic_sign = true
        -- error_sign = '',
        -- warn_sign = '',
        -- hint_sign = '',
        -- infor_sign = '',
        -- dianostic_header_icon = '   ',
        -- code_action_icon = ' ',
        -- code_action_prompt = {
        --   enable = true,
        --   sign = true,
        --   sign_priority = 20,
        --   virtual_text = true,
        -- },
        -- finder_definition_icon = '  ',
        -- finder_reference_icon = '  ',
        -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
        -- finder_action_keys = {
        --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
        -- },
        -- code_action_keys = {
        --   quit = 'q',exec = '<CR>'
        -- },
        -- rename_action_keys = {
        --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
        -- },
        -- definition_preview_icon = '  '
        -- "single" "double" "round" "plus"
        -- border_style = "single"
        -- rename_prompt_prefix = '➤',
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = {metals = {'sbt', 'scala'}}
        -- server_filetype_map = {}

        -- saga.init_lsp_saga {
        --   your custom option here
        -- }

        -- or --use default config
        -- require'lspsaga'.init_lsp_saga {
        --     use_saga_diagnostic_sign = false
        -- }
    end,
}

return M
