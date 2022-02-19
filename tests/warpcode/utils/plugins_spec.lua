describe('class', function()
    it('ensure requires', function()
        require 'warpcode.utils.plugins'
    end)
end)

describe('.get_plugin_name_from_path()', function()
    local plugins = require 'warpcode.utils.plugins'

    it('ensure we get expected names', function()
        assert.are.same('test', plugins.get_plugin_name_from_path('some/rand/path/test'))
    end)

    it('ensure .git suffix is removed', function()
        assert.are.same('test', plugins.get_plugin_name_from_path('some/rand/path/test.git'))
    end)
end)


describe('.get_plugin_path()', function()
    local plugins = require 'warpcode.utils.plugins'

    it('Ensure we get the path of a real installed plugin', function()
        local plugin_path = plugins.get_plugin_path('friendly-snippets')
        assert(plugin_path)
        assert(vim.fn.isdirectory(plugin_path))
    end)
end)
