if vim.fn['warpcode#packages#is_module_loaded']('symbols-outline') == 0 then
    return
end

-- local opts = {
-- 	-- whether to highlight the currently hovered symbol
-- 	-- disable if your cpu usage is higher than you want it
-- 	-- or you just hate the highlight
-- 	-- default: true
-- 	highlight_hovered_item = true,

-- 	-- whether to show outline guides
-- 	-- default: true
-- 	show_guides = true,
-- }

-- require("symbols-outline").setup(opts)
