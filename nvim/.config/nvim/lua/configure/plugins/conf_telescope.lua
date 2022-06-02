-- https://github.com/nvim-telescope/telescope.nvim

local mapping = require("core.mapping")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local M = {}

function M.before()
    M.register_global_key()
    map(
        '', '<leader>f', ':Telescope ',
        { noremap = true, silent = true, desc = 'Telescope prefix' }
    )
end

function M.load()
    require('telescope').setup {
        defaults = {
            -- sorting_strategy = "descending",
            -- need see document
            -- tiebreak =
            -- selection_strategy = "reset",
            -- scroll_strategy = "cycle",
            -- choices are: horizontal/center/cursor/vertical/flex/bottom_pane
            -- layout_strategy = "horizontal",
            layout_strategy = "flex",
            -- layout_strategy = "bottom_pane",
            -- layout_config = {
            --     bottom_pane = {
            --         height = 25,
            --         preview_cutoff = 120,
            --         prompt_position = "top"
            --     },
            --     center = {
            --         height = 0.4,
            --         preview_cutoff = 40,
            --         prompt_position = "top",
            --         width = 0.5
            --     },
            --     cursor = {
            --         height = 0.9,
            --         preview_cutoff = 40,
            --         width = 0.8
            --     },
            --     horizontal = {
            --         height = 0.9,
            --         preview_cutoff = 120,
            --         prompt_position = "bottom",
            --         width = 0.8
            --     },
            --     vertical = {
            --         height = 0.9,
            --         preview_cutoff = 40,
            --         prompt_position = "bottom",
            --         width = 0.8
            --     }
            -- },
            -- cycle_layout_list = { "horizontal", "vertical" },
            -- winblend = 0,
            -- wrap_results = false,
            -- prompt_prefix = '> ',
            -- selection_caret = '> ',
            -- entry_prefix = " ",
            -- multi_icon = '+',
            -- initial_mode = 'insert',
            -- border = true,
            -- path_display = { "truncate" },
            -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            -- see document
            -- get_status_text =
            -- hl_result_eol = true,
            -- dynamic_preview_title = false,
            -- results_title = "Results",
            -- see document
            -- history = require('telescope.actions.history').get_simple_history,
            -- cache_picker =
            -- preview =
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
            -- use_less = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            -- color_devicons = true,
            -- TODO
            mappings = {
                i = {
                    ['<C-h>'] = require('telescope.actions').select_vertical,
                    ['<C-j>'] = require('telescope.actions').move_selection_next,
                    ['<C-k>'] = require('telescope.actions').move_selection_previous,
                }
            },
            -- Not recommended to use except for advanced users.
            -- Will allow you to completely remove all of telescope's default maps and use your own.
            -- default_mappings = {}
            -- file_sorter = require("telescope.sorters").get_fuzzy_file,
            -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            -- prefilter_sorter = require("telescope.sorters").prefilter,
            file_ignore_patterns = { "node_modules" },
            -- get_selection_window = function() return 0 end
            -- file_previewer = require("telescope.previewers").cat.new,
            -- grep_previewer = require("telescope.previewers").vimgrep.new,
            -- qflist_previewer = require("telescope.previewers").qflist.new,
            -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            -- Parameters = {},
        },
        pickers = {
            find_files = {
                hidden = true,
            },
            live_grep = {
                -- don't include the filename in the search results
                only_sort_text = true,
            },
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = "delete_buffer",
                    },
                    n = {
                        ["dd"] = "delete_buffer",
                    },
                },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }
end

function M.after()
    require('telescope').load_extension('vim_bookmarks')
    require('telescope').load_extension('fzy_native')
    -- require"telescope".load_extension("frecency")
end

function M.register_global_key()
    mapping.register({
        {
            mode = { "n" },
            lhs = "<leader>ff",
            rhs = function()
                require("telescope.builtin").find_files()
            end,
            options = { silent = true },
            description = "Find files in the current workspace",
        },
        {
            mode = { "n" },
            lhs = "<leader>fg",
            rhs = function()
                require("telescope.builtin").live_grep()
            end,
            options = { silent = true },
            description = "Find string in the current workspace",
        },
        {
            mode = { "n" },
            lhs = "<leader>fo",
            rhs = function()
                require("telescope.builtin").oldfiles()
            end,
            options = { silent = true },
            description = "Find telescope history",
        },
        {
            mode = { "n" },
            lhs = "<leader>fh",
            rhs = function()
                require("telescope.builtin").resume()
            end,
            options = { silent = true },
            description = "Find last lookup",
        },
        {
            mode = { "n" },
            lhs = "<leader>ft",
            rhs = function()
                require("telescope.builtin").help_tags()
            end,
            options = { silent = true },
            description = "Find all help document tags",
        },
        {
            mode = { "n" },
            lhs = "<leader>fm",
            rhs = function()
                require("telescope.builtin").marks()
            end,
            options = { silent = true },
            description = "Find marks in the current workspace",
        },
        {
            mode = { "n" },
            lhs = "<leader>fi",
            rhs = function()
                require("telescope.builtin").highlights()
            end,
            options = { silent = true },
            description = "Find all neovim highlights",
        },
        {
            mode = { "n" },
            lhs = "<leader>fb",
            rhs = function()
                require("telescope.builtin").buffers()
            end,
            options = { silent = true },
            description = "Find all buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>f/",
            rhs = function()
                require("telescope.builtin").search_history()
            end,
            options = { silent = true },
            description = "Find all search history",
        },
        {
            mode = { "n" },
            lhs = "<leader>f:",
            rhs = function()
                require("telescope.builtin").command_history()
            end,
            options = { silent = true },
            description = "Find all command history",
        },
    })
end

return M
