-- Define the PriorityExecutor class
local M = {}

-- Initialize the call list
local callList = {}

-- Static method to execute a list of functions with priorities and early exit
function M.exec(name, ...)
    local calls = M.getCallsForBuffer(name, vim.api.nvim_get_current_buf())
    if not calls then
        vim.notify("No Matching callbacks for: " .. name, vim.log.levels.WARN)
        return nil
    end

    -- Execute the calls in order of priority
    -- We only run the first one anyways
    for _, call in ipairs(calls) do
        if type(call.func) == "function" then
            return call.func(call, ...)
        else
            return call.func
        end
    end
end

-- Static method to add a function call to the call list
function M.addCall(name, func, priority, buffer, payload, uniqid)
    -- As we add new calls, ensure invalid ones are removed
    M.filterInvalidBuffers()

    if not callList[name] then
        callList[name] = {}
    end

    -- remove anything on the same buffer with the same uniqid
    for index, call in pairs(callList[name]) do
        if call.uniqid and call.uniqid == uniqid and buffer == call.buffer then
            callList[name][index] = nil
        end
    end

    table.insert(callList[name], { func = func, priority = priority or 0, buffer = buffer, payload = payload, uniqid = uniqid })
end

-- Static method to retrieve a sorted list of calls
function M.getCalls(name)
    -- As we add new calls, ensure invalid ones are removed
    M.filterInvalidBuffers()
    table.sort(callList[name] or {}, function(a, b)
        return a.priority > b.priority
    end)

    return callList[name] or {}
end

-- Static method to retrieve a sorted list of calls filtered by a buffer id
function M.getCallsForBuffer(name, buffer)
    local calls = M.getCalls(name)
    local callsForBuffer = {}

    for _, call in ipairs(calls) do
        if not call.buffer or call.buffer == buffer then
            callsForBuffer[#callsForBuffer + 1] = call
        end
    end

    return callsForBuffer
end

-- Static method to remove calls for dead buffers
function M.filterInvalidBuffers()
    for name, calls in pairs(callList) do
        for index, call in pairs(calls) do
            if call.buffer and not vim.api.nvim_buf_is_loaded(call.buffer) then
                callList[name][index] = nil
            end
        end
    end
end

-- Return the PriorityExecutor class
return M
