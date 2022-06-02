-- conf_nvim-tree
-- plugin url: https://github.com/kyazdani42/nvim-tree.lua

local mapping = require('core.mapping')

local M = {}

M.before = function() end

M.load = function()
    require'nvim-tree'.setup {
    }
    mapping.register({
        {
            mode = {'n'},
            lhs = '<C-b>',
            rhs = ':NvimTreeToggle<cr>',
            options = { silent = true, noremap=true } ,
            description = "Toggle nvim-tree sidebar",
        }
    })
end


M.after = function() end


return M
