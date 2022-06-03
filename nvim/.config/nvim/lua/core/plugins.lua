-- local path = require("utils.path")
local util =require('util')

local packer_install_tbl = {
    --[[
	=====================================
	  ------------- basic -------------
	=====================================
	--]]
    -- https://github.com/wbthomason/packer.nvim
    ["wbthomason/packer.nvim"] = {}, -- package manager
    -- https://github.com/lewis6991/impatient.nvim
    ["lewis6991/impatient.nvim"] = {}, -- speed up startup
    -- https://github.com/nathom/filetype.nvim
    ["nathom/filetype.nvim"] = {}, -- speed up startup

    --[[
	=====================================
	  ------------ Depend ------------
	=====================================
	--]]
    -- https://github.com/kyazdani42/nvim-web-devicons
    ["kyazdani42/nvim-web-devicons"] = { -- neovim icons support
        after = { "impatient.nvim" },
    },
    ["nvim-lua/plenary.nvim"] = {},
    -- https://github.com/rcarriga/nvim-notify
    ["rcarriga/nvim-notify"] = { -- fancy notification message
        event = { "BufRead", "BufNewFile" },
    },
    -- https://github.com/lewis6991/gitsigns.nvim
    ['lewis6991/gitsigns.nvim'] = {},

    -- https://github.com/RRethy/nvim-base16
    ["RRethy/nvim-base16"] = {},

    --[[
	=====================================
	 ---------- Core function ----------
	=====================================
	--]]
    ['neovim/nvim-lspconfig'] = {},
    -- https://github.com/nvim-telescope/telescope.nvim
    ['nvim-telescope/telescope.nvim'] = {
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    },
    -- ["nvim-telescope/telescope-frecency.nvim"] = {
        -- requires = { "tami5/sqlite.lua" }
    -- },
    ['tom-anders/telescope-vim-bookmarks.nvim'] = {},
    ['nvim-telescope/telescope-file-browser.nvim'] = {},
    -- https://github.com/nvim-treesitter/nvim-treesitter
    ['nvim-treesitter/nvim-treesitter'] = {
        run = ':TSUpdate'
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {
        require = { {'nvim-treesitter/nvim-treesitter'} }
    },
    ['RRethy/nvim-treesitter-textsubjects'] = {
        require = { {'nvim-treesitter/nvim-treesitter'} }
    },
    -- ['nvim-treesitter/nvim-tree-docs'] = {
        -- require = { {'nvim-treesitter/nvim-treesitter'} }
    -- },
    ['m-demare/hlargs.nvim'] = {
        require = { {'nvim-treesitter/nvim-treesitter'} }
    },
    -- https://github.com/kyazdani42/nvim-tree.lua
    -- TODO
    ['kyazdani42/nvim-tree.lua'] = {
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
          },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },
    ["folke/todo-comments.nvim"] = {
        requires = "nvim-lua/plenary.nvim"
    },
    -- ['kevinhwang91/rnvimr'] = {},
    -- https://github.com/famiu/bufdelete.nvim
    -- ['famiu/bufdelete.nvim'] = {},
    -- https://github.com/folke/which-key.nvim
    ["folke/which-key.nvim"] = { -- keybinder
        event = { "BufRead", "BufNewFile" },
    },
    -- 如果这个插件稳定了，使用这一个？
    -- ['ggandor/leap.nvim'] = {},
    -- ['phaazon/hop.nvim'] = {
        -- branch = 'v1',
    -- },

    --[[
	=====================================
	 ----------       UI      ----------
	=====================================
	--]]
    -- https://github.com/akinsho/bufferline.nvim
    -- 1.2K
    ['akinsho/bufferline.nvim'] = {
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
    },
    ['sunjon/shade.nvim'] = {},
    ['winston0410/range-highlight.nvim'] = {
        requires = 'winston0410/cmd-parser.nvim',
    },
    -- Twilight 灰色掉其他部分的内容，依赖 treesitter
    ["folke/twilight.nvim"] = {},
    -- https://github.com/nvim-lualine/lualine.nvim
    ["nvim-lualine/lualine.nvim"] = { -- status bar plugin
        after = { "nvim-web-devicons", "gitsigns.nvim" },
    },
    ["folke/trouble.nvim"] = {
        requires = 'kyazdani42/nvim-web-devicons'
    },
    -- ["feline-nvim/feline.nvim"] = {},

    -- https://github.com/romgrk/barbar.nvim
    -- 1K
    -- ['romgrk/barbar.nvim'] = {
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- },
    -- 132 https://github.com/kdheepak/tabline.nvim
    -- 22  https://github.com/crispgm/nvim-tabline
    --[[
	=====================================
	 ----- language server protocol ----
	=====================================
	--]]
    -- ["neovim/nvim-lspconfig"] = { -- Basic LSP configuration support
        -- after = { "impatient.nvim" },
    -- },
    -- ["williamboman/nvim-lsp-installer"] = { -- automatically install LSP service
        -- after = { "nvim-lspconfig" },
    -- },
    -- ["Plug 'folke/lsp-colors.nvim'"] = {},
    --[[
	=====================================
	 ----------- Code Editor -----------
	=====================================
	--]]
    ["windwp/nvim-autopairs"] = { -- autocomplete parentheses
        event = { "InsertEnter" },
    },
    -- https://github.com/norcalli/nvim-colorizer.lua
    ["norcalli/nvim-colorizer.lua"] = {},
    ["lukas-reineke/indent-blankline.nvim"] = {},
    ['RRethy/vim-illuminate'] = {}, -- TODO
    -- ['numToStr/Comment.nvim'] = {},
    -- ['akinsho/toggleterm.nvim'] = {},
    ['danymat/neogen'] = {
        requires = 'nvim-treesitter/nvim-treesitter'
    },
    -- ['kevinhwang91/nvim-bqf'] = {
        -- ft = 'qf',
    -- },
}

-- local packer_install_tbl = {
--     ['nvim-treesitter/nvim-treesitter'] = {
--         run = ':TSUpdate'
--     },
--     -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--     ['nvim-treesitter/nvim-treesitter-textobjects'] = {
--         require = { {'nvim-treesitter/nvim-treesitter'} }
--     },
-- }

Packer_bootstrap = (function()
    local packer_install_path = util.join_paths(vim.fn.stdpath("data"), "site/pack/packer/start/packer.nvim")
    ---@diagnostic disable-next-line: missing-parameter
    if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
        local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
        vim.notify("Please wait ...\nInstalling packer package manager ...", "info", { title = "Packer" })
        if not string.find(vim.o.runtimepath, rtp_addition) then
            vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
        end
        return vim.fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            packer_install_path,
        })
    end
end)()

local packer = require("packer")

packer.init({
    git = {
        -- For Chinese users, if the download is slow, you can switch to the github mirror source
        -- replace : https://hub.fastgit.xyz/%s
        default_url_format = "https://github.com/%s",
        -- default_url_format = "https://hub.fastgit.xyz/%s",
    },
})

packer.startup({
    function(use)
        for plug_name, plug_config in pairs(packer_install_tbl) do
            local plug_options = vim.tbl_extend("force", { plug_name }, plug_config)
            local plug_filename = plug_options.as or string.match(plug_name, "/([%w-_]+).?")
            local load_disk_path = util.join_paths("configure", "plugins", "conf_" .. plug_filename:lower())
            local file_disk_path = util.join_paths(vim.fn.stdpath("config"), "lua", load_disk_path .. ".lua")
            if vim.fn.filereadable(file_disk_path) == 1 then
                if plug_config.ptp == "viml" then
                    plug_options.setup = [[
                        require("]] .. load_disk_path .. [[").entrance()
                    ]]
                else
                    -- vim(nvim) 的原生机制是将插件加入到runtime中
                    -- 对于nvim来说，其在runtime中找到名为lua的文件夹，将其作为lua程序的require来源
                    -- 可以查看 plugin/packer_compiled.lua 中 packer 的预处理后的结果
                    plug_options.setup = [[
                        require("]] .. load_disk_path .. [[").before()
                    ]]
                    plug_options.config = [[
						require("]] .. load_disk_path .. [[").load()
						require("]] .. load_disk_path .. [[").after()
					]]
                end
            else
                -- print('cannot load ' .. plug_name .. '\'s configuration file ' .. load_disk_path)
            end
            use(plug_options)
        end
        if Packer_bootstrap then
            packer.sync()
        end
    end,
    config = { display = { open_fn = require("packer.util").float } },
})

local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "plugins.lua" },
    command = "source <afile> | PackerCompile",
    group = packer_user_config,
})

return packer
