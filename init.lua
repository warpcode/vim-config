-- Get the folder where this init.lua lives
local base_dir = (function()
    local init_path = debug.getinfo(1, "S").source
    print(init_path)
    return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
  end)()

-- Add the config to the rtp
if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:prepend(base_dir)
  vim.opt.rtp:append(base_dir .. '/after')
end
