local Base = require('warpcode.projects.base')

local Martini = Base:new()

function Martini:new()
    local o = Base:new()

    setmetatable(o, self)
    self.__index = self
    self._base_files = {'initMartini.sh'}
    self._require_all_base_files = true

    return o
end

return Martini
