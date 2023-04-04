local events = {}
local M = {}

  M.addEventListener = function (event, listener)
    if not events[event] then
      events[event] = {}
    end
    table.insert(events[event], listener)
  end

  M.emit = function (event, ...)
    if not events[event] then
      return
    end
    for _, listener in ipairs(events[event]) do
      listener(event, ...)
    end
  end

return M
