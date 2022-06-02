-- conf_treesitter
-- plugin url: https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M.before = function() end

M.load = function()
  require'nvim-treesitter.configs'.setup {
    textsubjects = {
      enable = true,
      prev_selection = ',', -- (Optional) keymap to select the previous selection
      keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
      },
    },
    -- A list of parser names, or "all"
    ensure_installed = {
      "bash", "lua", 'python', 'javascript', 'c', 'cpp', 'css', 'cuda', 'go', 'html',
      'java', 'json', 'latex', 'markdown', 'r', 'rst', 'rust', 'scala', 'scss', 'toml',
      'vim', 'vue', 'yaml'
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing (for "all")
    ignore_install = {},
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      -- list of language that will be disabled
      disable = {},
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        -- init_selection = '<M-w>',
        -- node_incrnnental = 'grn',
        node_incrnnental = 'grn',
        -- node_decremental = 'grm',
        node_decremental = 'grm',
        scope_inccemental = 'grc',
      },
    },
    -- tree_docs = { enable = true, },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ak"] = "@class.outer",
          ["ik"] = "@class.inner",
          -- 使用 'glts/vim-textobj-comment'
          -- ["ic"] = "@comment.outer",
          -- ["ac"] = "@comment.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]k"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]K"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[k"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[K"] = "@class.outer",
        },
      }
    },
  }
  -- 开启 Folding
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  -- 默认不要折叠
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  vim.o.foldlevel = 99
end


M.after = function() end


return M
