-- This will be included where mason is setup to run
--
-- To allow other plugins to add linters to require('lint').linters_by_ft,
-- instead set linters_by_ft like this:
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- However, note that this will enable a set of default linters,
-- which will cause errors unless these tools are available:
-- {
--   clojure = { "clj-kondo" },
--   dockerfile = { "hadolint" },
--   inko = { "inko" },
--   janet = { "janet" },
--   json = { "jsonlint" },
--   markdown = { "vale" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- You can disable the default linters by setting their filetypes to nil:
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil
local M = {}

M.servers = {
    json = { 'jsonlint' },
    markdown = { 'markdownlint' },
    php = { 'php', 'phpcs' },
    python = { 'flake8' },
    zsh = { 'zsh' },
}

M.mason_ignore = {
    'php',
    'zsh',
}

M.args_override = {
    phpcs = {
        '-q',
        '--standard=PSR12',
        '--report=json',
        '-'
    }
}

M.get_mason_tool_names = function()
    local tools = {}

    for _, x in pairs(M.servers) do
        local ft_tools = vim.deepcopy(vim.deepcopy(x))

        for key, value in pairs(ft_tools) do
            if not vim.tbl_contains(M.mason_ignore, value) then
                tools[#tools+1] = value
            end
        end
    end

    return tools
end

return M
