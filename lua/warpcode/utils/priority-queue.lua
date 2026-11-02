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
  local p = priority or 0
  local d = data or {}
  local queue = self.queue

  -- Find existing item with same buffer and uniqid to update
  if uniqid then
    for i = 1, #queue do
      local call = queue[i]
      if call.uniqid == uniqid and call.buffer == buffer then
        if call.priority == p then
          call.data = d
          return
        else
          table.remove(queue, i)
          break
        end
      end
    end
  end

  -- Binary search insertion index for descending order
  local low = 1
  local high = #queue
  local pos = #queue + 1
  while low <= high do
    local mid = math.floor((low + high) / 2)
    local item = queue[mid]
    local item_p = item and item.priority or 0
    if item_p < p then
      pos = mid
      high = mid - 1
    else
      low = mid + 1
    end
  end

  table.insert(queue, pos, { priority = p, buffer = buffer, uniqid = uniqid, data = d })
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
  local is_loaded_cache = {}
  local is_loaded = vim.api.nvim_buf_is_loaded

  for _, call in ipairs(self.queue) do
    local buf = call.buffer
    if not buf then
      table.insert(new_queue, call)
    else
      local loaded = is_loaded_cache[buf]
      if loaded == nil then
        loaded = is_loaded(buf)
        is_loaded_cache[buf] = loaded
      end
      if loaded then
        table.insert(new_queue, call)
      end
    end
  end
  self.queue = new_queue
end

return PQueue
