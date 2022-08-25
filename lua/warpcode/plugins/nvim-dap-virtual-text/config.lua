local status, dap_vtext = pcall(require, 'nvim-dap-virtual-text')

return {
    run = function()
        if not status then return end

        dap_vtext.setup()
    end
}
