local Base = require('warpcode.projects.base')

local VimConfig = Base:new()

--- Construct a new instance of the class
---@param buffnr int
function VimConfig:new(buffnr)
    local o = Base:new(buffnr)

    setmetatable(o, self)
    self.__index = self
    self._project_name = 'Vim Config'
    self._project_name_slug = 'vim-config'
    self._root_detection = 'files'
    self._root_detection_type = 'strict'
    self._root_base_files = {'init.vim', 'vimrc'}

    return o
end

return VimConfig
