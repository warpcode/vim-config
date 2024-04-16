local ClassObject = {}
ClassObject.__index = ClassObject

--- Used as a constructor
function ClassObject:new() end
function ClassObject:init() end

--- When creating a new class, use this method
--- to extend this base class
function ClassObject:extend()
    local o = {}
    for k, v in pairs(self) do
        if k:find("__") == 1 then
            o[k] = v
        end
    end
    o.__index = o
    o.super = self
    setmetatable(o, self)
    return o
end

--- Use another classes methods in this class
function ClassObject:implement(...)
    for _, o in pairs({...}) do
        for k, v in pairs(o) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

function ClassObject:is(T)
    local mt = getmetatable(self)
    while mt do
        if mt == T then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end

function ClassObject:__tostring()
    return "New Class Object"
end

--- Called like a function to instantiate the class
--- e.g local instance = YourClass(arg1, arg2)
function ClassObject:__call(...)
    local obj = setmetatable({}, self)
    obj:new(...)
    obj:init()
    return obj
end

return ClassObject
