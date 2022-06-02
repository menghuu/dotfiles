-- https://github.com/famiu/bufdelete.nvim
local mappping = require('core.mapping')

local M = {}

M.before = function()
    -- 这里的快捷键最好在vim中使用的那个vim-bbye设置的一样
    mappping.register({
        {
            mode = {'n'},
            lhs = '\\c',
            rhs = function()
                require('bufdelete').bufdelete(0)
            end,
            options = { silent = true, noremap=true } ,
            description = "Bdelete buffer from bufferlist WITHOUT change layout",
        },
        {
            mode = {'n'},
            lhs = '\\q',
            rhs = function()
                require('bufdelete').bufwipeout(0)
            end,
            options = { silent = true, noremap=true },
            description = "Bwipeout buffer from bufferlist WITHOUT change layout",
        }
    })
end

M.load = function()


end


M.after = function() end

return M
