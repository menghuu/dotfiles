-- https://github.com/akinsho/bufferline.nvim
local mapping = require("core.mapping")

local M = {}

M.before = function()
  mapping.register({{
    mode = {"n"},
    lhs = "[b",
    rhs = ':BufferLineCyclePrev<CR>',
    options = {
      silent = true,
      noremap = true
    },
    description = "Goto previous buffer by bufferline.nvim"
  }, {
    mode = {"n"},
    lhs = "]b",
    rhs = ':BufferLineCycleNext<CR>',
    options = {
      silent = true,
      noremap = true
    },
    description = "Goto next buffer by bufferline.nvim"
  }, {
    mode = {'n'},
    lhs = '<M-o>',
    rhs = ":BufferLinePick<CR>",
    options = {
      silent = true,
      noremap = true
    },
    description = "Pick a buffer by bufferline.nvim"
  }})
end

M.load = function()
  require('bufferline').setup {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      --   numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      numbers = "buffer_id",
      --   numbers = function(opts)
      --     return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
      --   end,
      --   close_command = "Bdelete %d",       -- can be a string | function, see "Mouse actions"
      close_command = function(bufnum)
        local ok, bufdelete = pcall(require, 'bufdelete')
        if ok then -- use https://github.com/famiu/bufdelete.nvim
          bufdelete.bufdelete(bufnum)
        elseif vim.fn.exists('Bdelete') == 1 then -- use https://github.com/moll/vim-bbye
          vim.cmd('Bdelete ' .. bufnum)
        else -- use vim default bdelete
          vim.cmd('bdelete ' .. bufnum)
        end
      end,
      --   right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "vert sbnext %d",
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = "BufferLineTogglePin", -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator_icon = '▎',
      --   buffer_close_icon = '',
      buffer_close_icon = '✕',
      modified_icon = '●',
      --   close_icon = '',
      close_icon = '✘',
      --   left_trunc_marker = '',
      left_trunc_marker = '<',
      --   right_trunc_marker = '',
      right_trunc_marker = '>',
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        -- remove extension from markdown files for example
        if buf.name:match('%.md') then
          return vim.fn.fnamemodify(buf.name, ':t:r')
        end
      end,
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      --   diagnostics = false | "nvim_lsp" | "coc",
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          return true
        end
        -- filter out by it's index number in list (don't show first buffer)
        if buf_numbers[1] ~= buf_number then
          return true
        end
      end,
      --   offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
      --   color_icons = true | false, -- whether or not to add the filetype icon highlights
      color_icons = true,
      --   show_buffer_icons = true | false, -- disable filetype icons for buffers
      show_buffer_icons = true,
      --   show_buffer_close_icons = true | false,
      show_buffer_close_icons = true,
      --   show_buffer_default_icon = true | false, -- whether or not an unrecognised filetype should show a default icon
      show_buffer_default_icon = true,
      --   show_close_icon = true | false,
      show_close_icon = true,
      --   show_tab_indicators = true | false,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      --   separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
      --   enforce_regular_tabs = false | true,
      --   always_show_bufferline = true | false,
      --   sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      -- return buffer_a.modified > buffer_b.modified
      --   end
      offsets = {{
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }}
    }
  }
end

M.after = function()
end

return M
