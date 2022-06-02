-- conf_hop: 此插件及其不成熟，bug太多了，文档也不成熟，暂时不使用了，实际上，easymotion 也不是很有用啊
-- url: https://github.com/phaazon/hop.nvim
local mappping = require('core.mapping')


local M = {}

M.before = function() end


-- place this in one of your configuration file(s)
-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
-- vim.api.nvim_set_keymap('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})

M.load = function()
    -- options = { silent = true, noremap=true }

    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>f',
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = false })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>F',
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = false })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>t',
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>T',
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>w',
    --     "<cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>W',
    --     "<cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,  hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>e',
    --     "<cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_position = require'hop.hint'.HintPosition.END })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )
    -- vim.api.nvim_set_keymap(
    --     '', '<leader><leader>E',
    --     "<cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,  hint_position = require'hop.hint'.HintPosition.END })<cr>",
    --     { silent = true, noremap=true , desc = "" }
    -- )


    require('hop').setup {}
end

M.after = function() end


return M
