--local new_class = require('warpcode.utils.class')
--local ProgressAlert = new_class:extend()

----- Construct a new instance of the base projects class----- Construct a new instance of the base projects class
-----@param buffnr int
--function ProgressAlert:new()
--    self.notification = nil
--    self.run_in_progress = false
--    self.current_frame = 1
--    self.title = 'Alert'
--    self.message = ''
--    self.default_spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
--end

--function ProgressAlert:init()
--    self:set_spinner_frames(self.default_spinner_frames)
--end

--function ProgressAlert:set_spinner_frames(spinner)
--    if type(spinner) ~= 'table' then
--        spinner = {spinner}
--    end

--    self.spinner_frames = spinner
--end

--function ProgressAlert:get_spinner_frame()
--    local frame_nr = self.current_frame % #self.spinner_frames
--    self.current_frame = frame_nr + 1

--    return self.spinner_frames[frame_nr]
--end

--function ProgressAlert:set_title(title)
--    self.title = title
--end

--function ProgressAlert:set_message(message)
--    self.message = message
--end

--function ProgressAlert:is_running()
--    return self.notification ~= nil
--end

--function ProgressAlert:start(title, message)
--    if title then self:set_title(title) end
--    if message then self:set_message(message) end

--    self.current_frame = 1
--    self.notification = vim.notify(self.message, "info", {
--        title = self.title,
--        icon = self:get_spinner_frame(),
--        timeout = false,
--        replace = self.notification,
--        hide_from_history = true,
--    })

--    self.run_in_progress = true
--    self:progress_loop()
--end

--function ProgressAlert:progress_loop()
--    if not self:is_running() or not self.run_in_progress then
--        return
--    end

--    self.notification = vim.notify(nil, nil, {
--        icon = self:get_spinner_frame(),
--        replace = self.notification,
--    })

--    vim.defer_fn(function()
--        self:progress_loop()
--    end, 500)
--end

--function ProgressAlert:success(title, message)
--    if not self:is_running() then
--        return
--    end

--    local notification = self.notification
--    self:halt()

--    local timeout = 3000

--    if title then self:set_title(title) end
--    if message then self:set_message(message) end

--    vim.notify(self.message, "info", {
--        title = self.title,
--        icon = "",
--        -- replace = notification,
--        timeout = timeout,
--        hide_from_history = false,
--    })

--end

--function ProgressAlert:error(title, message)
--    if not self:is_running() then
--        return
--    end

--    local notification = self.notification
--    self:halt()

--    local timeout = 3000

--    if title then self:set_title(title) end
--    if message then self:set_message(message) end

--    vim.notify(self.message, "error", {
--        title = self.title,
--        icon = "",
--        -- replace = notification,
--        timeout = timeout,
--        hide_from_history = false,
--    })
--end

--function ProgressAlert:halt()
--    self.run_in_progress = false

--    -- Ensure the progress loop notification
--    -- is removed by adding a timeout
--    if self:is_running() then
--        vim.notify(nil, nil, {
--            replace = self.notification,
--            timeout = 100,
--        })
--        self.notification = nil
--    end
--end

--local test = ProgressAlert()
--test:start('title', 'message here')
--vim.defer_fn(
--    function()
--        test:error('YAY', 'WE DID IT')
--        test:success('YAY', 'WE DID IT')
--    end,
--    5000
--)

--return ProgressAlert
