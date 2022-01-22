local Base = require('warpcode.projects.base')

local Martini = Base:new()

--- Construct a new instance of the class
---@param buffnr int
function Martini:new(buffnr)
    local o = Base:new(buffnr)

    setmetatable(o, self)
    self.__index = self
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

    return o
end

return Martini
