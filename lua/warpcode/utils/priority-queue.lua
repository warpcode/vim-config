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
  self:filterInvalidBuffers()

  -- remove anything on the same buffer with the same uniqid
  for index, call in pairs(self.queue) do
    if call.uniqid and call.uniqid == uniqid and buffer == call.buffer then
      self.queue[index] = nil
    end
  end

  table.insert(self.queue, { priority = priority or 0, buffer = buffer, uniqid = uniqid, data = data or {} })

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

-- Method to remove calls for dead buffers
function PQueue:sortList()
  if #self.queue < 2 then
    return
  end

  -- sort the entries
  table.sort(self.queue, function(a, b)
    return a.priority > b.priority
  end)
end

-- Method to remove calls for dead buffers
function PQueue:filterInvalidBuffers()
  for index, call in pairs(self.queue) do
    if call.buffer and not vim.api.nvim_buf_is_loaded(call.buffer) then
      self.queue[index] = nil
    end
  end
end

return PQueue
