local cmp_ok, cmp = pcall(require, 'cmp')
local _, cmp_compare = pcall(require, 'cmp.config.compare')
local luasnip_ok, luasnip = pcall(require, 'luasnip')
local strings = require('warpcode.utils.string')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local default_sort = {
    priority_weight = 2,
    comparators = {
        -- require('cmp_tabnine.compare'),
        -- cmp_compare.offset,
        -- cmp_compare.exact,
        -- cmp_compare.score,
        -- cmp_compare.recently_used,
        -- cmp_compare.kind,
        -- cmp_compare.sort_text,
        -- cmp_compare.length,
        cmp_compare.order,
    },
}


return {
    run = function()
        if not cmp_ok then return end

        -- Setup nvim-cmp.
        local source_mapping = {
            buffer = '[buf]',
            calc = '[calc]',
            cmp_tabnine = '[tab9]',
            luasnip = '[snip]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[lua]',
            omni = '[omni]',
            path = '[fs]',
            treesitter = '[ts]',
        }

        local opts = {
            experimental = {
                -- native_menu = true,
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    -- For `vsnip` user.
                    -- vim.fn["vsnip#anonymous"](args.body)

                    -- For `luasnip` user.
                    if luasnip_ok then
                        luasnip.lsp_expand(args.body)
                    end

                    -- For `ultisnips` user.
                    -- vim.fn["UltiSnips#Anon"](args.body)
                end,
            },
            mapping = {
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                -- ['<CR>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip_ok and luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip_ok and luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },

            formatting = {
                format = function(entry, vim_item)
                    -- vim_item.kind = require('lspkind').presets.default[vim_item.kind]
                    -- vim_item.kind = ''
                    local menu = source_mapping[entry.source.name] or "[" .. strings.ucfirst(entry.source.name) .. "]"
                    if entry.source.name == 'cmp_tabnine' then
                        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                            menu = entry.completion_item.data.detail .. ' ' .. menu
                        end
                        -- vim_item.kind = ''
                    end
                    vim_item.menu = menu
                    return vim_item
                end
            },
            sorting = default_sort,
            sources = {
                { name = "cmp_tabnine" },
                { name = "nvim_lsp" },
                { name = "treesitter" },
                -- For vsnip user.
                -- { name = 'vsnip' },
                -- For luasnip user.
                { name = "luasnip" },
                -- For ultisnips user.
                -- { name = 'ultisnips' },
                { name = 'calc' },
                { name = 'emoji' },
                -- { name = "omni" },
                { name = "nvim_lua" },
            }, {
                {
                    name = "buffer",
                    keyword_length = 5,
                    max_item_count = 10,
                },
                { name = "path" },
            },
        };

        cmp.setup(opts)

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                { name = "cmp_tabnine" },
                require('warpcode.plugins.cmp.sources.gh_issues'),
                require('warpcode.plugins.cmp.sources.spell'),
            }, {
                { name = 'buffer' },
            }),
            sorting = default_sort,
        })

        -- Use buffer source for `/`.
        cmp.setup.cmdline('/', {
            completion = { autocomplete = false },
            sources = {
                -- { name = 'buffer' }
            { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
            }
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
            completion = { autocomplete = false },
            sources = cmp.config.sources({
            { name = 'path' }
            }, {
                { name = 'cmdline' }
                })
        })

    end
}
