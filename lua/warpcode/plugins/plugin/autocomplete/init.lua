return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    return
                end

                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
                {
                    'honza/vim-snippets',
                    config = function()
                        require('luasnip.loaders.from_snipmate').lazy_load()
                    end,
                },
            },
            config = function()
                require('luasnip.loaders.from_lua').lazy_load()
                -- luasnip.config.setup({
                --     history = true,
                --     updateevents = 'TextChanged,TextChangedI',
                --     enable_autosnippets = true,
                --     ft_func = require 'warpcode.plugins.snippets.luasnip'.get_filetypes,
                --     parser_nested_assembler = function(_, snippet)
                --         local select = function(snip, no_move)
                --             snip.parent:enter_node(snip.indx)
                --             -- upon deletion, extmarks of inner nodes should shift to end of
                --             -- placeholder-text.
                --             for _, node in ipairs(snip.nodes) do
                --                 node:set_mark_rgrav(true, true)
                --             end
                --
                --             -- SELECT all text inside the snippet.
                --             if not no_move then
                --                 vim.api.nvim_feedkeys(
                --                     vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                --                     "n",
                --                     true
                --                 )
                --                 local pos_begin, pos_end = snip.mark:pos_begin_end()
                --                 util.normal_move_on(pos_begin)
                --                 vim.api.nvim_feedkeys(
                --                     vim.api.nvim_replace_termcodes("v", true, false, true),
                --                     "n",
                --                     true
                --                 )
                --                 util.normal_move_before(pos_end)
                --                 vim.api.nvim_feedkeys(
                --                     vim.api.nvim_replace_termcodes("o<C-G>", true, false, true),
                --                     "n",
                --                     true
                --                 )
                --             end
                --         end
                --         function snippet:jump_into(dir, no_move)
                --             if self.active then
                --                 -- inside snippet, but not selected.
                --                 if dir == 1 then
                --                     self:input_leave()
                --                     return self.next:jump_into(dir, no_move)
                --                 else
                --                     select(self, no_move)
                --                     return self
                --                 end
                --             else
                --                 -- jumping in from outside snippet.
                --                 self:input_enter()
                --                 if dir == 1 then
                --                     select(self, no_move)
                --                     return self
                --                 else
                --                     return self.inner_last:jump_into(dir, no_move)
                --                 end
                --             end
                --         end
                --
                --         -- this is called only if the snippet is currently selected.
                --         function snippet:jump_from(dir, no_move)
                --             if dir == 1 then
                --                 return self.inner_first:jump_into(dir, no_move)
                --             else
                --                 self:input_leave()
                --                 return self.prev:jump_into(dir, no_move)
                --             end
                --         end
                --
                --         return snippet
                --     end
                -- })
            end,
        },

        -- Other completion capabilities
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-omni',
        'hrsh7th/cmp-path',
        'ray-x/cmp-treesitter',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        cmp.setup {
            experimental = {
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            mapping = cmp.mapping.preset.insert {
                -- Select the [n]ext item
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<C-y>'] = cmp.mapping.confirm { select = true },

                -- Abort the completion.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete {},

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            formatting = {
                format = function(entry, vim_item)
                    local menu_symbols = {
                        buffer = '[buf]',
                        calc = '[calc]',
                        luasnip = '[snip]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[lua]',
                        omni = '[omni]',
                        path = '[fs]',
                        treesitter = '[ts]',
                    }

                    local lspkind_ok, lspkind = pcall(require, 'lspkind')
                    if lspkind_ok then
                        -- From lspkind if installed
                        return  lspkind.cmp_format({
                            menu = (menu_symbols)
                        })(entry, vim_item)
                    end

                    local menu = menu_symbols[entry.source.name] or ('[' .. entry.source.name .. ']')
                    vim_item.menu = menu

                    return vim_item
                end
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'treesitter' },
                { name = 'calc' },
                { name = 'emoji' },
                { name = 'path' },
            },
        }

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
            --     -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            --     currently broken and won't load. possibly caching?
            --     require('warpcode.plugins.plugin.autocomplete.sources.gh_issues'),
            --     require('warpcode.plugins.plugin.autocomplete.sources.spell'),
            -- }, {
                { name = 'buffer' },
            }),
        })

        -- Use buffer source for `/`.
        -- Not working currently
        -- cmp.setup.cmdline('/', {
        --     completion = { autocomplete = true },
        --     sources = {
        --         { name = 'treesitter' },
        --         -- { name = 'buffer' }
        --         { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
        --     }
        -- })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
            completion = { autocomplete = false },
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end,
}
