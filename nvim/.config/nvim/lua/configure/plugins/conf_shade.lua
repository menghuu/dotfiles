-- conf_shade
-- plugin url:

local M = {}


M.before = function() end


M.load = function()
    require'shade'.setup({
        overlay_opacity = 50,
        opacity_step = 1,
        keys = { }
    })
end


M.after = function() end


return M
