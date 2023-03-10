local config = require('warpcode.lsp.config')
require"lspconfig".emmet_ls.setup(config.common({}))
