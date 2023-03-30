pcall(function()
    require 'cmp_tabnine.config':setup({
        max_lines = 1000,
        max_num_results = 2,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
    })
end)
