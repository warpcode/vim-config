local class = require('warpcode.utils.class')
local merge_tables = require('warpcode.utils.tables').merge_tables
local has_nvim  = vim.fn.has('nvim') == 1
local vim_home = ''
local vim_source = ''
if has_nvim then
    vim_home = vim.g.vim_home
    vim_source = vim.g.vim_source
else
    vim_home = vim.eval('g:vim_home')
    vim_source = vim.eval('g:vim_source')
end

local PackageManager = class()

function PackageManager:init()
    self.configs = {
        lazy = {},
        start = {}
    }
    self.pm_object = nil
    self.pm = 'vim-plug'
end

function PackageManager:set_package_manager(package_manager)
    self.pm = package_manager
end

function PackageManager:run()
    self:__install_package_manager()

    if self.pm == 'packer' then
        vim.cmd [[packadd packer.nvim]]

        require('packer').init({
            package_root = vim.fn.stdpath('config') .. '/pack',
        })

        require('packer').startup(function(use)
            -- Packer can manage itself
            use 'wbthomason/packer.nvim'

            self.pm_object = use
            self:__autoload_packages()
            -- Automatically set up your configuration after cloning packer.nvim
            -- Put this at the end after all plugins
            -- if WARPCODE_PACKAGES_BOOTSTRAP then
            --     require('packer').sync()
            -- end
        end)
    else
        vim.fn['plug#begin'](vim_home .. '/plugged')
        self:__autoload_packages()
        vim.fn['plug#end']()

        for _, config in pairs(self.configs.start) do
            config()
        end
    end
end

function PackageManager:__get_install_path()
    if self.pm == 'packer' then
        return vim_home..'/pack/packer/start/packer.nvim'
    else
       return vim_home..'/autoload/plug.vim'
    end
end

function PackageManager:__install_path_exists()
    local install_path = self:__get_install_path();

    return vim.fn.empty(vim.fn.glob(install_path)) < 1
end

function PackageManager:__install_package_manager()
    if self:__install_path_exists() then
        -- If already installed, skip it
        return
    end

    local install_path = self:__get_install_path();
    local cmd_output = nil

    if self.pm == 'packer' then
        if vim.fn.executable("git") == 0 then
            error("You have to install git or first install packer yourself!")
        end

        cmd_output = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    else
        if vim.fn.executable("curl") == 0 then
            error("You have to install curl or first install vim-plug yourself!")
        end

        cmd_output = vim.fn.system({'curl', '-fLo', install_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
    end

    if not self:__install_path_exists() then
        error('Package manager "'..self.pm..'" failed to install')
    end
end

function PackageManager:__autoload_packages()
    local glob_result = vim.fn.glob(vim_source..'/lua/warpcode/package-manager/packages/*.lua')
    local file_list = vim.fn.split(glob_result, "\n")

    for _, value in pairs(file_list) do
        local filename = vim.fn.fnamemodify(value, ':t:r')
        require('warpcode.package-manager.packages.' .. filename)(self)
    end
end

function PackageManager:load_packages(config_list)
    for key, value in pairs(config_list) do
        -- Grab the packer manager specific config
        local opts = value[self.pm] or {}

        if vim.fn.has('nvim') == 0 then
            -- vim expects it's own dictionary format
            opts = vim.dict(opts)
        elseif not next(opts) then
            -- If the dictionary is empty in nvim, we must force an empty dictionary
            opts = vim.empty_dict()
        end

        if self.pm == 'packer' then
            self.pm_object(merge_tables({key}, opts))
        else
            -- Process aliases
            opts['do'] = opts.run
            opts.run = nil

            opts['for'] = opts.ft
            opts.ft = nil

            vim.fn['plug#'](key, opts)

            -- Add support to load config
            if type(opts.config) == 'function' then
                local plugin = opts.as or self:__get_package_name(key)

                if opts['for'] == nil and opts.on == nil then
                    self.configs.start[plugin] = opts.config
                else
                    self.configs.lazy[plugin] = opts.config

                    -- local user_cmd = [[ autocmd! User %s ++once lua VimPlugApplyConfig('%s') ]]
                    -- vim.cmd(user_cmd:format(plugin, plugin))
                end

            end
        end
    end
end

function PackageManager:__get_package_name(repo)
    return repo:match("^[%w-]+/([%w-_.]+)$")
end

local pm = PackageManager()

if vim.fn.has('nvim') == 1 then
    pm:set_package_manager('packer')
end

return pm
