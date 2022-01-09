local luasnip_status, luasnip = pcall(require, 'luasnip')

if (not luasnip_status) then  
    return
end

local snippets_snipmate_module_paths = function()
	local plugins = { "vim-snippets" }
	local paths = {
        vim.g.vim_source .. '/modules/snippets_snipmate'
    }
	for _, plug in ipairs(plugins) do
		local path = vim.fn['warpcode#packages#module_loaded_path'](plug)
		if path ~= '' and vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end

	return paths
end

local snippets_vscode_module_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {
        vim.g.vim_source .. '/modules/snippets_vscode'
    }
	for _, plug in ipairs(plugins) do
		local path = vim.fn['warpcode#packages#module_loaded_path'](plug)
		if path ~= '' and vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end

	return paths
end

local snippets_snipmate_paths = snippets_snipmate_module_paths()
local snippets_vscode_paths = snippets_vscode_module_paths()

-- Load snipmate style snippets
if #snippets_snipmate_paths > 0 then
    -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
    -- are stored in `ls.snippets._`.
    -- We need to tell luasnip that "_" contains global snippets:
    -- luasnip.filetype_extend("all", { "_" })

    -- require("luasnip.loaders.from_snipmate").lazy_load({
    --     path = snippets_snipmate_paths
    -- })
end

-- Load vscode style snippets
if #snippets_vscode_paths > 0 then
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = snippets_vscode_paths,
        include = nil, -- Load all languages
        exclude = {}
    })
end
