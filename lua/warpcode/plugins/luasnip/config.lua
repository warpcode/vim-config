local luasnip_ok, luasnip = pcall(require, 'luasnip')
local _, util = pcall(require, 'luasnip.util.util')
local wplugins = require 'warpcode.utils.plugins'

return {
    run = function()
        if not luasnip_ok then return end

        local snippets_snipmate_module_paths = function()
            local plugins = { "vim-snippets" }
            local paths = {
                vim.g.vim_source .. '/snippets'
            }
            for _, plug in ipairs(plugins) do
                local path = wplugins.get_plugin_path(plug) or ''
                if path ~= '' and vim.fn.isdirectory(path .. '/snippets') ~= 0 then
                    table.insert(paths, path .. '/snippets')
                end
            end

            return paths
        end

        local snippets_vscode_module_paths = function()
            local plugins = { "friendly-snippets" }
            local paths = {
                vim.g.vim_source
            }
            for _, plug in ipairs(plugins) do
                local path = wplugins.get_plugin_path(plug) or ''
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
            luasnip.filetype_extend("all", { "_" })

            require("luasnip.loaders.from_snipmate").load({
                paths = snippets_snipmate_paths
            })
        end

        -- Load vscode style snippets
        if #snippets_vscode_paths > 0 then
            require("luasnip.loaders.from_vscode").load({
                paths = snippets_vscode_paths,
                include = nil, -- Load all languages
                exclude = {}
            })
        end

        luasnip.config.setup({
            history = true,
            updateevents = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            ft_func = function()
                local filetypes = require 'luasnip.extras.filetype_functions'.from_pos_or_filetype() or {}
                return require 'warpcode.projects'.get_filetypes(filetypes)
            end,
            parser_nested_assembler = function(_, snippet)
                local select = function(snip, no_move)
                    snip.parent:enter_node(snip.indx)
                    -- upon deletion, extmarks of inner nodes should shift to end of
                    -- placeholder-text.
                    for _, node in ipairs(snip.nodes) do
                        node:set_mark_rgrav(true, true)
                    end

                    -- SELECT all text inside the snippet.
                    if not no_move then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                            "n",
                            true
                        )
                        local pos_begin, pos_end = snip.mark:pos_begin_end()
                        util.normal_move_on(pos_begin)
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("v", true, false, true),
                            "n",
                            true
                        )
                        util.normal_move_before(pos_end)
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("o<C-G>", true, false, true),
                            "n",
                            true
                        )
                    end
                end
                function snippet:jump_into(dir, no_move)
                    if self.active then
                        -- inside snippet, but not selected.
                        if dir == 1 then
                            self:input_leave()
                            return self.next:jump_into(dir, no_move)
                        else
                            select(self, no_move)
                            return self
                        end
                    else
                        -- jumping in from outside snippet.
                        self:input_enter()
                        if dir == 1 then
                            select(self, no_move)
                            return self
                        else
                            return self.inner_last:jump_into(dir, no_move)
                        end
                    end
                end
                -- this is called only if the snippet is currently selected.
                function snippet:jump_from(dir, no_move)
                    if dir == 1 then
                        return self.inner_first:jump_into(dir, no_move)
                    else
                        self:input_leave()
                        return self.prev:jump_into(dir, no_move)
                    end
                end
                return snippet
            end
        })
    end
}
