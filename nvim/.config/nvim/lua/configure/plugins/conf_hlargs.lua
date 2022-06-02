-- conf_hlargs
-- plugin url: https://github.com/m-demare/hlargs.nvim

local M = {}


M.before = function() end


M.load = function()
  require('hlargs').setup()
end


M.after = function() end


return M
