local symbols_outline_ok, symbols_outline = pcall(require, 'symbols-outline')

return {
    run = function()
        if not symbols_outline_ok then return end

        local opts = {
            -- whether to highlight the currently hovered symbol
            -- disable if your cpu usage is higher than you want it
            -- or you just hate the highlight
            -- default: true
            highlight_hovered_item = true,

            -- whether to show outline guides
            -- default: true
            show_guides = true,
        }

        symbols_outline.setup(opts)
    end
}

