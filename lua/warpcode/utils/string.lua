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

--- Check a string starts with another string
---@param s string
---@param n string
---@return bool
M.startswith = function(s, n)
	return s:sub(1, #n) == n
end

--- Check a string ends with another string
---@param s string
---@param str string
---@return bool
M.endswith = function(s, str)
  return s:sub(-#str) == str
end

--- Converts the first letter to upper case
---@param str string
---@return string
M.ucfirst = function(str)
    return (str:gsub("^%l", string.upper))
end

return M
