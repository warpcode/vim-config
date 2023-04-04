-- Define the PriorityExecutor class
local M = {}

-- Initialize the call list
local callList = {}

-- Static method to execute a list of functions with priorities and early exit
function M.exec(name, ...)
    if not callList[name] then
        return nil
    end

    -- Sort the calls by priority (highest first)
    table.sort(callList[name], function(a, b) return a.priority > b.priority end)


    -- Execute the calls in order of priority
    for _, call in ipairs(callList[name]) do
        local success, result = pcall(call.func, ...)
        if success and (not call.condition or call.condition(result)) then
            return result
        end
    end

    -- Return nil if no call succeeds
    return nil
end

-- Static method to add a function call to the call list
function M.addCall(name, func, priority, condition)
    if not callList[name] then
        callList[name] = {}
    end

    table.insert(callList[name], { func = func, priority = priority, condition = condition })
end

-- Return the PriorityExecutor class
return M
