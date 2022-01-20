local Base = require('warpcode.projects.base')

local Martini = Base:new()

--- Construct a new instance of the class
---@param buffnr int
function Martini:new(buffnr)
    local o = Base:new(buffnr)

    setmetatable(o, self)
    self.__index = self
    self._base_files = {'initMartini.sh'}
    self._require_all_base_files = true

    return o
end

return Martini
