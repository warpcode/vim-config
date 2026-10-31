PQueue = { id = 'PQueue' }
PQueue.__index = PQueue
function PQueue:create()
  local this = {
    queue = {},
  }
  setmetatable(this, PQueue)
  return this
end

function PQueue:add(priority, buffer, uniqid, data)
  -- Find existing item with same buffer and uniqid to update
  local found = false
  if uniqid then
    for _, call in ipairs(self.queue) do
      if call.uniqid == uniqid and call.buffer == buffer then
        call.priority = priority or 0
        call.data = data or {}
        found = true
        break
      end
    end
  end

  if not found then
    table.insert(self.queue, { priority = priority or 0, buffer = buffer, uniqid = uniqid, data = data or {} })
  end

  self:sortList()
end

-- Method to remove calls for dead buffers
function PQueue:getItems(buffer)
  self:filterInvalidBuffers()
  local filteredItems = {}

  for _, item in ipairs(self.queue) do
    if not item.buffer or item.buffer == buffer then
      table.insert(filteredItems, item)
    end
  end

  return filteredItems
end

function PQueue:getFirstItem(buffer)
  local items = self:getItems(buffer)

  if #items == 0 then
    return nil
  end

  return items[1]
end

-- Method to sort the queue by priority
function PQueue:sortList()
  if #self.queue < 2 then
    return
  end

  -- sort the entries
  table.sort(self.queue, function(a, b)
    local apriority = a and a.priority or 0
    local bpriority = b and b.priority or 0
    return apriority > bpriority
  end)
end

-- Method to remove calls for dead buffers
function PQueue:filterInvalidBuffers()
  local new_queue = {}
  for _, call in pairs(self.queue) do
    if not call.buffer or vim.api.nvim_buf_is_loaded(call.buffer) then
      table.insert(new_queue, call)
    end
  end
  self.queue = new_queue
end

return PQueue
