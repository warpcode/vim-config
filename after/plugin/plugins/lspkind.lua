pcall(function()
    require 'lspkind'.init({
        mode = 'symbol_text',
    })

    --https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
    vim.cmd [[
        " gray
        highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
        " blue
        highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
        highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
        " light blue
        highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
        highlight! link CmpItemKindInterface CmpItemKindVariable
        highlight! link CmpItemKindText CmpItemKindVariable
        " pink
        highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
        highlight! link CmpItemKindMethod CmpItemKindFunction
        " front
        highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
        highlight! link CmpItemKindProperty CmpItemKindKeyword
        highlight! link CmpItemKindUnit CmpItemKindKeyword
    ]]
end)
