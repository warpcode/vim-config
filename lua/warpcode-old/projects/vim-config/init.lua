local Base = require('warpcode.projects.base')

local VimConfig = Base:extend()

--- Construct a new instance of the class
---@param buffnr int
function VimConfig:new(buffnr)
    VimConfig.super.new(self, buffnr)

    self._project_name = 'Vim Config'
    self._project_name_slug = 'vim-config'
    self._root_detection = 'files'
    self._root_detection_type = 'strict'
    self._root_base_files = {'init.vim', 'vimrc'}
    self._project_command_name = 'VimConfig'
end

return VimConfig
