local treesitter_configs_status, treesitter_configs = pcall(require, 'nvim-treesitter.configs')

if (not treesitter_configs_status) then
    return
end

local config = {
    ensure_installed = "all",
    ignore_install = {
        'beancount',
        'bibtex',
        'clojure',
        'commonlisp',
        'cuda',
        'dart',
        'dot',
        'eex',
        'elixir',
        'elm',
        'erlang',
        'fennel',
        'fish',
        'foam',
        'fortran',
        'fusion',
        'gdscript',
        'glimmer',
        'glsl',
        'gowork',
        'hack',
        'haskell',
        'hcl',
        'heex',
        'hocon',
        'julia',
        'kotlin',
        'ledger',
        'ninja',
        'nix',
        'norg',
        'ocaml',
        'ocaml_interface',
        'pascal',
        'perl',
        'pioasm',
        'prisma',
        'pug',
        'ql',
        'r',
        'rasi',
        'rst',
        'scala',
        'sparql',
        'supercollider',
        'surface',
        'svelte',
        'tlaplus',
        'turtle',
        'vala',
        'verilog',
        'yang',
        'zig',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true
    },
    -- rainbow = {
    --     enable = true,
    --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
    --     -- colors = {}, -- table of hex strings
    --     -- termcolors = {} -- table of colour name strings
    -- }
}

treesitter_configs.setup(config)
