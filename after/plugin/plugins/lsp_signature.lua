pcall(function()
    require("lsp_signature").setup({
        -- bind = false,
        -- floating_window = true,
        -- floating_window_off_x = 1, -- adjust float windows x position.
        -- floating_window_off_y = 1000, -- adjust float windows y position.
        -- hint_enable = true,
        -- -- hi_parameter = "Search",
        -- handler_opts = {
        --     border = "shadow"   -- double, rounded, single, shadow, none
        -- },
        -- fix_pos = function(signatures, _) -- second argument is the client
        --     return signatures.activeParameter >= 0 and #signatures.parameters > 1
        -- end,
    })
end)
