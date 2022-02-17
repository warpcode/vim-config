local cmp_status, cmp = pcall(require, 'cmp')
local luasnip_status, luasnip = pcall(require, 'luasnip')
local strings = require('warpcode.utils.string')

if (not cmp_status) then  
    return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
            if luasnip_status then
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
			elseif luasnip_status and luasnip.expand_or_locally_jumpable() then
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
			elseif luasnip_status and luasnip.jumpable(-1) then
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

	sources = cmp.config.sources({
        { name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "treesitter" },
        -- For vsnip user.
		-- { name = 'vsnip' },
		-- For luasnip user.
		{ name = "luasnip" },
		-- For ultisnips user.
		-- { name = 'ultisnips' },
    }, {
		{ name = "omni" },
		{ name = "nvim_lua" },
        {name = 'calc'}, 
        {name = 'emoji'},
    }, {
		{
            name = "spell",
            max_item_count = 5,
        },
		{ 
            name = "buffer", 
            keyword_length = 5,
            max_item_count = 10,
        },
		{ name = "path" },
	}),
};

cmp.setup(opts)
cmp.register_source('spell', require('warpcode.packages.cmp.sources.spell').new())

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

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000,
    max_num_results = 2,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
})
