local new_class = require('warpcode.utils.class')
local buffers = require('warpcode.utils.buffers')
local wtables = require('warpcode.utils.tables')
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
    self._project_command_name = ''
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

    self._buffnr = buffers.get_bufnr(buffnr)
end

function Base:init()
    if not self:is_project() then
        -- Don't attach if there's no matching project
        return
    end

    self:_on_attach()
end

--- Run this private method when attaching to the buffer
function Base:_on_attach()
    self:command_register()
    self:on_attach()
end

--- Override this method for custom actions when attaching to the buffer 
function Base:on_attach() end

--- Simply return the name of the project
---@param slug string
---@return string
function Base:get_project_name(slug)
    if slug then
        return self._project_name_slug
    end

    return self._project_name
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

    local file = path.get_file_buf_or_cwd(self._buffnr)
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

function Base:get_root()
    if not self._root or self._root == '' then
        return nil
    end

    return self._root
end

--- Can be used with lua snip to load in additional filetype snippets
--- The existing filetype must be passed through
---@param filetype string|table
---@return table
function Base:get_filetypes(filetypes)
    local ft = wtables.list_force(filetypes or buffers.get_file_types(self._buffnr))
    local new_ft = vim.deepcopy(ft)

    for _, ft in pairs(ft) do
        new_ft = wtables.list_extend(new_ft, self:get_additional_filetypes_aliases(ft))
        new_ft = wtables.list_extend(new_ft, self:get_additional_filetypes_custom(ft))
    end

    return wtables.list_unique(new_ft)
end

--- Retrieve additional filetypes from the internal alias list
--- This list is for only very simple mappings.
---@param filetype string
---@return table
function Base:get_additional_filetypes_aliases(filetype)
    local matches = {}

    if type(self._ft_aliases) == 'table' then
        matches = wtables.list_extend(matches, self._ft_aliases[filetype] or {})
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

--- Register the project command
function Base:command_register()
    local command_name = self._project_command_name or ''
    if command_name == '' then
        return
    end

    self:command_deregister()
    vim.api.nvim_buf_add_user_command(
        self._buffnr, 
        command_name, 
        function(...) 
            return self:command_run(...) 
        end, 
        {
            complete = function(...) return self:command_complete(...) end,
            nargs = '+'
        }
    )
end

--- Register the project command
function Base:command_deregister()
    local command_name = self._project_command_name or ''
    if command_name == '' then
        return
    end

    pcall(vim.api.nvim_buf_del_user_command, self._buffnr, command_name)
end

--- Core autocompletion for project commands
function Base:command_complete(arg, line, pos)
    return commands.complete(arg, line, pos, self._project_commands)
end

--- Core function to run the specified command
function Base:command_run(args)
    return commands.run(args, self._project_commands)
end

return Base
