return {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --

  bashls = {},
  dockerls = {},
  emmet_ls = {},
  html = {},
  intelephense = {
    init_options = {
      licenceKey = (function()
        local licenceKeyFile = vim.fn.expand('~/intelephense/licence.key')
        local licence = nil
        local f = io.open(licenceKeyFile, 'rb')
        if f ~= nil then
          -- Read a single line to get the key
          licence = f:read('*l')
          f:close()
        end

        return licence
      end)(),
    },
  },
  jsonls = {},
  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- runtime = {
        --     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        --     version = "LuaJIT",
        --     vim.split(package.path, ";"),
        -- },
        -- diagnostics = {
        -- Get the language server to recognize the `vim` global
        -- globals = { "vim" },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- disable = { 'missing-fields' }
        -- },
        -- workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file("", true),
        -- },
        telemetry = {
          -- Do not send telemetry data containing a randomized but unique identifier
          enable = false,
        },
      },
    },
  },
  pylsp = {},
  sqlls = {
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('.sqllsrc.json')(fname) or util.find_git_ancestor(fname)
    end,
  },
  ts_ls = {},
  vimls = {},
}
