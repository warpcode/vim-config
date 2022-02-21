local ok, tabnine = pcall(require, 'cmp_tabnine.config')

return {
    run = function()
        if not ok then return end

        tabnine:setup({
            max_lines = 1000,
            max_num_results = 2,
            sort = true,
            run_on_every_keystroke = true,
            snippet_placeholder = '..',
        })
    end
}
