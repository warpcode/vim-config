local path = require('warpcode.utils.path')
local Base = {}

--- Construct a new instance of the base projects class
---@param buffnr int
function Base:new(buffnr)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self._base_files = {}
    self._require_all_base_files = false
    self._file = nil
    self._root = nil

    -- Register the buffer number so this instance is "attached" to a buffer
    if type(buffnr) == 'number' and buffnr > 0 then
        self._buffnr = buffnr
    else
        self._buffnr = vim.api.nvim_get_current_buf()
    end

    return o
end

--- Construct a new instance from a file path
---@param file string
function Base:from_file(file)
    file = path.get_file_buf_or_cwd(file)
    local object = self:new()
    local root_dir = object:get_project_root(file)

    object._file = file
    object._root = root_dir

    return object
end

--- Ensure root directory has been found
---@param force boolean Force the class to re-find the root dir
function Base:assert_root_directory(force)
    if not force and self._root ~= nil then
        return
    end

    local file = vim.api.nvim_buf_get_name(self._buffnr)

    if not file or file == '' then 
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

    return path.root_pattern(
        self._base_files or {},
        file,
        self._require_all_base_files
    )
end

--- Check if the current instance detected a root directory for this project type
---@return bool
function Base:is_project()
    self:assert_root_directory()

    return self._root ~= ''
end
return Base
