local new_class = require('warpcode.utils.class')
local commands = require('warpcode.utils.commands')
local path = require('warpcode.utils.path')
local Base = new_class:extend()

--- Construct a new instance of the base projects class
---@param buffnr int
function Base:new(buffnr)
    self._project_name = ''
    self._project_name_slug = ''
    self._root_detection = 'files'
    self._root_detection_type = 'loose'
    self._root_base_files = {}
    self._root_folder_name = ''
    self._root = nil
    self._ft_aliases = {}
    self._project_commands = {
        children = {
            get = {
                children = {
                    name = {
                        run = function(args, extra_args)
                            print(self:get_project_name(extra_args[1] == 'short'))
                        end,
                    },
                    root = {
                        run = function()
                            self:is_project()
                            print(self._root)
                        end,
                    },
                },
            },
        }
    }

    -- Register the buffer number so this instance is "attached" to a buffer
    if type(buffnr) == 'number' and buffnr > 0 then
        self._buffnr = buffnr
    else
        self._buffnr = vim.api.nvim_get_current_buf()
    end

    self:command_register()
end

--- Simply return the name of the project
---@param slug string
---@return string
function Base:get_project_name(slug)
    if slug then
        return self._project_name_slug
    end

    return self._project_name
end

--- Return the buffer number
function Base:get_buffnr()
    return self._buffnr 
end

--- Check if the buffer is valid
function Base:has_valid_buffer()
    return vim.api.nvim_buf_is_valid(self._buffnr) 
end

--- Ensure root directory has been found
---@param force boolean Force the class to re-find the root dir
function Base:assert_root_directory(force)
    if not force and self._root ~= nil then
        return
    end

    -- Set _root to empty string as any failures from here
    -- means a root directory could not be set
    self._root = self._root or ''

    if not self:has_valid_buffer() then 
        return
    end

    local file = vim.api.nvim_buf_get_name(self._buffnr)

    if not file or file == '' then 
        -- if we have a valid buffer but it's not from a file
        -- default to the current working directory
        file = vim.fn.getcwd()
    end

    self._root = self:find_project_root(file) or ''
end

--- Scan for this projects root directory
---@param file string
function Base:find_project_root(file)
    -- If still no path, force empty string to signify failure
    if not file or file == '' then 
        return nil
    end

    local detection_type = self._root_detection_type == 'strict'
    if self._root_detection == 'files' then
        return path.root_pattern(
            self._root_base_files or {},
            file,
            detection_type
        )
    elseif self._root_detection == 'folder_name' then
        return path.root_pattern_by_parent_name(
            self._root_folder_name or {},
            file,
            detection_type
        )
    end

    return nil
end

--- Check if the current instance detected a root directory for this project type
---@return bool
function Base:is_project()
    self:assert_root_directory()

    return self._root ~= ''
end

--- Can be used with lua snip to load in additional filetype snippets
--- The existing filetype must be passed through
---@param filetype string|table
---@return table
function Base:get_filetypes()
    if not self:has_valid_buffer() then 
        return {}
    end

    local buffer_filetype = vim.api.nvim_buf_get_option(self._buffnr, 'filetype')
    local filetypes = vim.split(buffer_filetype, '.', true)

    if not self:is_project() then
        -- Don't get extra file types if the file is not even in the project
        return filetypes
    end

    -- Use deep copy as it would create an infinite loop
    local new_ft = vim.deepcopy(filetypes)
    for _, ft in pairs(filetypes) do
        -- First check the simple mappings
        -- These mappings apply no matter what if the filetype matches
        local additional_ft = self:get_additional_filetypes_aliases(ft)
        vim.list_extend(new_ft, additional_ft)

        -- Now look for more dynamic custom mappings
        local custom_ft = self:get_additional_filetypes_custom(ft)
        vim.list_extend(new_ft, custom_ft)
    end

    return new_ft
end

--- Retrieve additional filetypes from the internal alias list
--- This list is for only very simple mappings.
---@param filetype string
---@return table
function Base:get_additional_filetypes_aliases(filetype)
    local matches = {}

    if type(self._ft_aliases) == 'table' then
        local ft_aliases = {}
        if type(self._ft_aliases[filetype]) == 'table' then
            ft_aliases = self._ft_aliases[filetype]
        elseif type(self._ft_aliases[filetype]) == 'string' then
            ft_aliases = {self._ft_aliases[filetype]}
        end 

        vim.list_extend(matches, ft_aliases)
    end

    return matches
end

--- Retrieve additional filetypes from custom checks.
--- This method should be overriden if dynamic checking is required.
--- Example of use would be detecting whether a js file is 
--- in a legacy js build, legacy legacy build or new build and add a mapping 
--- depending on which the js file belongs to.
--- For example you could have myproject-javascriptv2, myproject-javascript-legacy
--- and then create extra luasnips snippets to have targeted snippets without poullting
--- files that don't need them
---@param filetype string
---@return table
function Base:get_additional_filetypes_custom(filetype)
    return {}
end

function Base:command_register()
    if not self:has_valid_buffer() then 
        return
    end

    pcall(vim.api.nvim_buf_del_user_command, self._buffnr, 'Project')
    vim.api.nvim_buf_add_user_command(self._buffnr, 'Project', function(...) return self:command_run(...) end, {
        complete = function(...) return self:command_complete(...) end,
        nargs = '+'
    })
end

function Base:command_complete(arg, line, pos)
    return commands.complete(arg, line, pos, self._project_commands)
end

function Base:command_run(args)
    return commands.run(args, self._project_commands)
end

return Base
