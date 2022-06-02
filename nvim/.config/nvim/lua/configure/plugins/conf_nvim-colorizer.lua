-- config
-- url: https://github.com/norcalli/nvim-colorizer.lua


local M = {}

M.before = function() end

M.load = function()
    require('colorizer').setup()
end


M.after = function() end


return M
