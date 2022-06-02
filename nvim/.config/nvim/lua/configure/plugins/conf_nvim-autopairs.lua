-- https://github.com/windwp/nvim-autopairs

local M = {}


M.before = function() end

M.load = function()
    require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt"},
        fast_wrap = {}, -- <M-e> fast wrap `(|foo` `(|)foo`快速括住foo
    })
end

M.after = function() end


return M
