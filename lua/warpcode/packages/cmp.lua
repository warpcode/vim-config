if vim.fn['warpcode#packages#is_module_loaded']('nvim-cmp') == 0 then
    return
end

local wvim = require('warpcode.utils.vim')
local strings = require('warpcode.utils.string')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buf]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
}

cmp.setup({
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
			-- 	luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- 	luasnip.jump(-1)
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
            -- if entry.source.name == 'cmp_tabnine' then
            --     if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            --         menu = entry.completion_item.data.detail .. ' ' .. menu
            --     end
            --     vim_item.kind = ''
            -- end
            vim_item.menu = menu
            return vim_item
        end
    },

	sources = {
        -- tabnine completion? yayaya
        -- { name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = 'vsnip' },
		{ name = "buffer" },
		{ name = "path" },
	},
})
--
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

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
--     max_lines = 1000,
--     max_num_results = 20,
--     sort = true,
-- 	run_on_every_keystroke = true,
-- 	snippet_placeholder = '..',
-- })

-- vim.lsp.set_log_level("debug")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


--[[  I cannot seem to get this woring on new computer..
require("lspconfig").clangd.setup(config({
	cmd = { "clangd", "--background-index", "--log=verbose" },
    root_dir = function()
        print("clangd-Rootdir", vim.loop.cwd())
		return vim.loop.cwd()
	end,
}))
--]]
-- require("lspconfig").ccls.setup(config())

-- require("lspconfig").jedi_language_server.setup(config())

-- require("lspconfig").svelte.setup(config())

-- require("lspconfig").solang.setup(config())


-- require("lspconfig").gopls.setup(config({
-- 	cmd = { "gopls", "serve" },
-- 	settings = {
-- 		gopls = {
-- 			analyses = {
-- 				unusedparams = true,
-- 			},
-- 			staticcheck = true,
-- 		},
-- 	},
-- }))

-- -- who even uses this?
-- require("lspconfig").rust_analyzer.setup(config({}))

-- require("lspconfig").sumneko_lua.setup(config({
-- 	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 				-- Setup your lua path
-- 				path = vim.split(package.path, ";"),
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = {
-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }))
