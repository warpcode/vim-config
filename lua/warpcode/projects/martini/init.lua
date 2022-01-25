local Base = require('warpcode.projects.base')

local Martini = Base:extend()

--- Construct a new instance of the class
---@param buffnr int
function Martini:new(buffnr)
    Martini.super.new(self, buffnr)

    self._project_name = 'Martini'
    self._project_name_slug = 'martini'
    self._root_detection = 'files'
    self._root_base_files = {'initMartini.sh'}
    self._ft_aliases = {
        html = {
            'martini-html'
        },
        php = {
            'martini-php'
        },
    }
end

return Martini
