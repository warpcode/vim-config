local pq = require('warpcode.utils.priority-queue')

-- Define the PriorityExecutor class
local M = {}

-- Initialize the call list
local callList = {}

-- Static method to execute a list of functions with priorities and early exit
function M.getAction(name, ...)
  local args = ...

  return function()
    if not callList[name] then
      return ''
    end
    local item = callList[name]:getFirstItem(vim.api.nvim_get_current_buf())

    if not item then
      return ''
    end

    if type(item.data.fn) == 'function' then
      return item.data.fn(item, args)
    else
      return item.data.fn or ''
    end
  end
end

-- Static method to add a function call to the call list
function M.addCall(name, fn, priority, buffer, payload, uniqid)
  if not callList[name] then
    callList[name] = pq:create()
  end

  callList[name]:add(priority, buffer, uniqid, { fn = fn, payload = payload })
end

return M
