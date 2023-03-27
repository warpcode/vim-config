-- Structure for commands
-- {
--     run = function() print("test") end,
--     children = {
--         this = {
--             run = function() return {} end,
--         },
--         is = {
--             run = function() return {} end,
--             children = {
--                 aaaaa = {
--                     run = function() return {} end,
--                 },
--             },
--         },
--         are = function() return {
--             run = function() return {} end,
--             children = {
--                 aaaaa = {
--                     run = function() return {} end,
--                     children = function()
--                         return {
--                             test = {
--                                 run = function(...) warpcode.print({...}) end,
--                             },
--                         }
--                     end,
--                 },
--             }
--         }
--         end,
--         fail = function()
--             return {
--             }
--         end,
--         object = {
--             children = {
--                 one = {
--                 },
--                 two = {
--                 },
--                 three = {
--                 },
--             },
--         },
--     }
-- }


--- Return check for a table or a function that returns a table
---@param entry table|function|nil
---@return table|nil
local function get_table_or_run_fn(entry, ...)
    if type(entry) == 'table' then
        return vim.deepcopy(entry)
    end

    if type(entry) == 'function' then
        return entry(...)
    end

    return nil
end

--- Splits a command into a list
---@param cmd string
---@param remove_first boolean|nil
---@param remove_last boolean|nil
---@return table
local function split(cmd, remove_first, remove_last)
    local split_command = vim.fn.split(cmd, [[\%(\%(\%(^\|[^\\]\)\\\)\@<!\s\)\+]], 1)

    if remove_first then
        table.remove(split_command, 1);
    end

    if remove_last then
        table.remove(split_command, #split_command);
    end

    return split_command
end

--- Recursively scan the argument list for a command entry
---@param _args table
---@param _arg_list table|function
---@return table|function|nil, table|function|nil
local function get_command(_args, _arg_list)
    local arg_list = get_table_or_run_fn(_arg_list, {
        remaining_args = _args
    })

    local args = vim.deepcopy(_args)

    if type(args) ~= 'table' or #args == 0 then
        return arg_list, args
    end

    local first_arg = args[1]
    local child_list = get_table_or_run_fn(arg_list.children, {
        remaining_args = _args
    })

    if type(child_list) ~= 'table' or not child_list[first_arg] then
        -- no children so assume we're at our command with additional args
        return arg_list, args
    end

    -- Remove the first item as we're grabbing it for the next recursion
    table.remove(args, 1)
    return get_command(args, child_list[first_arg])
end


local M = {}

--- Run the specified command
---@param _args table
---@param _arg_list table
M.run = function(_args, _arg_list)
    local args = split(_args.args)
    local command_config, remaining_args = get_command(args, _arg_list)

    if type(command_config) ~= 'table' then
        error("Command cannot be ran")
    end

    local child_list = get_table_or_run_fn(command_config.children, {
        remaining_args = remaining_args
    })

    if type(command_config.run) ~= 'function' then
        -- command has no run function
        -- Check if there are children available and display the appropriate message
        if type(child_list) ~= 'table' or not next(child_list) then
            error('Command cannot be ran')
        else
            error('More parameters required')
        end
    end

    command_config.run(_args, remaining_args)
end

--- Run the autocomplete check
---@param _arg string
---@param _line string
---@param _pos number
---@param _arg_list table
---@return table
M.complete = function(_arg, _line, _pos, _arg_list)
    local args = split(_line, true, true)
    local command_config, remaining_args = get_command(args, _arg_list)

    if type(command_config) ~= 'table' then
        return {}
    end

    -- If we have remaining args, it means a child was not matched
    -- with the left over args
    -- Therefore we are matching on params.
    local child_list = {}
    if #remaining_args == 0 then
        child_list = get_table_or_run_fn(command_config.children, {
                remaining_args = remaining_args
            }) or {}
    end

    local params_list = get_table_or_run_fn(command_config.params, {
            remaining_args = remaining_args
        }) or {}

    vim.list_extend(params_list, vim.tbl_keys(child_list))
    print(vim.inspect(params_list))
    print(vim.inspect(remaining_args))

    return vim.tbl_filter(
        function(entry)
            return not vim.tbl_contains(remaining_args, entry)
        end,
        params_list
    )
end

---Setup the command to run
---@param buf integer|nil
---@param command string|nil
---@param config table
M.register = function(buf, command, config)
    command = command or ''
    if command == '' then
        return
    end

    M.deregister(buf, command)
    vim.api.nvim_buf_create_user_command(
        buf or 0,
        command,
        function(args)
            return M.run(args, config)
        end,
        {
            complete = function(arg, line, pos)
                return M.complete(arg, line, pos, config)
            end,
            nargs = '*'
        }
    )
end

---Deregister command
---@param buf integer|nil
---@param command string|nil
M.deregister = function(buf, command)
    command = command or ''
    if command == '' then
        return
    end

    pcall(vim.api.nvim_buf_del_user_command, buf or 0, command)
end


return M
