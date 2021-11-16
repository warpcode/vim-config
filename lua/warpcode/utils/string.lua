local M = {}

M.split = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

-- Converts the first letter to upper case
-- @param string str
M.ucfirst = function(str)
    return (str:gsub("^%l", string.upper))
end

return M
