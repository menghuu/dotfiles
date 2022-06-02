-- conf_neogen
-- plugin url:

local M = {}


M.before = function() end


M.load = function()
    require('neogen').setup {}
end


M.after = function() end


return M
