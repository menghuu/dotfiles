-- https://github.com/nvim-lualine/lualine.nvim

local M = {
  filter_ft = {
    "NvimTree",
    "aerial",
    "dbui",
  },
}

M.before = function()

end

M.load = function()
    require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'codedark',
      -- https://en.wikibooks.org/wiki/Unicode/List_of_useful_symbols
      -- 选择自己喜欢的、并且能够正常显示的标识符，省的还得使用打补丁的字体，简单点
      -- section 中包含若干个 component
      component_separators = { left = '𝄥', right = '𝄥'},
      section_separators = { left = '⋮', right = '⋮'},
      disabled_filetypes = {},
      always_divide_middle = true,
      -- 如果是true，则所有窗口都使用同一个statusline
      globalstatus = false,
    },
    sections = {
      -- left
      lualine_a = {
        {
          "mode",
          cond = function()
              return not vim.tbl_contains(M.filter_ft, vim.o.filetype)
          end,
          fmt = M.trunc(22, 0, nil, true),
        },
      },
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      -- right
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
end

M.after = function() end


function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
      local win_width = vim.fn.winwidth(0)
      if hide_width and win_width < hide_width then
          return ""
      elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
      end
      return str
  end
end

return M
