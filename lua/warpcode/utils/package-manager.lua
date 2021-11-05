local class = require('warpcode.utils.class')
local string = require('warpcode.utils.string')
local wvim = require('warpcode.utils.vim')
local merge_tables = require('warpcode.utils.tables').merge_tables
local vim_home = wvim.get_var('vim_home', 'g')
local vim_source = wvim.get_var('vim_source', 'g')

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
        wvim.cmd [[packadd packer.nvim]]

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

        wvim.cmd([[command! -nargs=0 PackageManagerVimEnter lua PKGS:VimEnter()]])
        wvim.cmd([[autocmd! VimEnter * :PackageManagerVimEnter]])

        vim.fn['plug#begin'](vim_home .. '/plugged')
        self:__autoload_packages()
        vim.fn['plug#end']()
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
        if not wvim.has_executable('git') then
            error("You have to install git or first install packer yourself!")
        end

        cmd_output = os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim "' .. install_path .. '"')
    else
        if not wvim.has_executable('curl') then
            error("You have to install curl or first install vim-plug yourself!")
        end

        cmd_output = os.execute('curl -fLo "' .. install_path .. '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    end

    if not self:__install_path_exists() then
        error('Package manager "'..self.pm..'" failed to install')
    end
end

function PackageManager:__autoload_packages()
    local glob_result = vim.fn.glob(vim_source..'/lua/warpcode/packages/*.lua')
    local file_list = string.split(glob_result, "\n")

    for _, value in pairs(file_list) do
        local filename = vim.fn.fnamemodify(value, ':t:r')
        require('warpcode.packages.' .. filename)(self)
    end
end

function PackageManager:load_packages(config_list)
    for key, value in pairs(config_list) do
        -- Grab the packer manager specific config
        local opts = value or {}

        if vim.fn.has('nvim') == 1 and not next(opts) then
            -- If the dictionary is empty in nvim, we must force an empty dictionary
            opts = vim.empty_dict()
        end

        if self.pm == 'packer' then
            self.pm_object(merge_tables({key}, opts))
        else
            if not opts.disable then
                -- Process aliases
                opts['do'] = opts.run
                opts.run = nil

                opts['for'] = opts.ft
                opts.ft = nil

                opts.on = opts.cmd
                opts.cmd = nil

                -- Add support to load config
                if type(opts.config) == 'function' then
                    local plugin = opts.as or self:__get_package_name(key)

                    if opts['for'] == nil and opts.on == nil then
                        opts.on = 'PackageManagerVimEnter'
                    end

                    self.configs.lazy[plugin] = opts.config

                    local user_cmd = [[ autocmd! User %s ++once lua PKGS:run_lazy_load_config('%s') ]]

                    wvim.cmd(user_cmd:format(plugin, plugin))
                end

                if vim.fn.has('nvim') == 0 then
                    opts = vim.dict(opts)
                end
                -- Load the plugin conf to vim-plug
                vim.fn['plug#'](key, opts)
            end
        end
    end
end

function PackageManager:__get_package_name(repo)
    return repo:match("^[%w-]+/([%w-_.]+)$")
end

function PackageManager:run_lazy_load_config(plugin_name)
  local fn = self.configs.lazy[plugin_name]
  if type(fn) == 'function' then fn() end
end

function PackageManager:VimEnter()
    -- Dummy method for vim enter to run and vim-plug to pick up
end

function PackageManager:load_configs()
    if self.pm == 'vim-plug' then
        for _, config in pairs(self.configs.start) do
            config()
        end
    end
end

local pm = PackageManager()

if wvim.is_nvim() then
    pm:set_package_manager('packer')
end

_G.PKGS = pm
