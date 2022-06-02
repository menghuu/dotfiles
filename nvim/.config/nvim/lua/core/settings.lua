local settings = {
    g = {
        -- Enable Lua's ftplugin
        do_filetype_lua = 1,
    },
    opt = {
    },
    disable_builtin_plugins = {
    },
}

if not vim.fn.has('nvim-0.6.0') then
    -- Do not source the default filetype.vim
    vim.g.did_load_filetypes = 1
end

-- vim.g.do_filetype_lua = 1


for prefix, tab in pairs(settings) do
    if prefix ~= "disable_builtin_plugins" then
        for key, value in pairs(tab) do
            -- print(string.format('set %s %s = %s', prefix, key, value))
            vim[prefix][key] = value
        end
    else
        for _, plugin in pairs(tab) do
            vim.g["loaded_" .. plugin] = 1
        end
    end
end

return settings
