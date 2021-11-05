if has('lua') || has('nvim')
    " Init package manager configs if there's any
    lua PKGS:load_configs()
endif
