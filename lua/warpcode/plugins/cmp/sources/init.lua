local cmp = require "cmp"

return cmp.config.sources({
    { name = "cmp_tabnine" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    -- For vsnip user.
    -- { name = 'vsnip' },
    -- For luasnip user.
    { name = "luasnip" },
    -- For ultisnips user.
    -- { name = 'ultisnips' },
    {name = 'calc'}, 
    {name = 'emoji'},
    require('warpcode.plugins.cmp.sources.gh_issues'),
}, {
    { name = "omni" },
    { name = "nvim_lua" },
}, {
    require('warpcode.plugins.cmp.sources.spell'),
    { 
        name = "buffer",
        keyword_length = 5,
        max_item_count = 10,
    },
    { name = "path" },
})
