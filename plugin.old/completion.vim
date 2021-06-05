let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


lua require'lspconfig'.phpactor.setup{}
lua require'lspconfig'.bashls.setup{}
