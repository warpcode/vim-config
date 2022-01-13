local path = require('warpcode.utils.path')
local Base = {}

--- Construct a new instance of the base projects class
function Base:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self._base_files = {}
    self._require_all_base_files = false
    self._file = nil
    self._root = nil

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

--- Check if the current instance detected a root directory for this project type
function Base:is_project()
    return self._root ~= nil
end

--- Scan for this projects root directory
---@param file string
function Base:get_project_root(file)
    if self._root ~= nil then
        return self._root
    end

    return path.root_pattern(
        self._base_files or {}, 
        path.get_file_buf_or_cwd(local_path),
        self._require_all_base_files
    )
end

return Base
