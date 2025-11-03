-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"sharkdp/fd",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ "AckslD/nvim-neoclip.lua" },

	-- Themes
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "tomasiser/vim-code-dark", name = "code-dark" },
	"Mofiqul/vscode.nvim",
	{ "catppuccin/vim", name = "catppuccin" },
	"rebelot/kanagawa.nvim",
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
	--{
	--"lukas-reineke/indent-blankline.nvim",
	--dependencies = {
	--"TheGLander/indent-rainbowline.nvim",
	--},
	--},

	-- Trees
	"nvim-tree/nvim-tree.lua",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"mbbill/undotree",

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"Shougo/deoplete.nvim",
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
			"cohama/lexima.vim",
			"saadparwaiz1/cmp_luasnip",
			"honza/vim-snippets",
			"zbirenbaum/copilot-cmp",
		},
	},
	"nvimdev/lspsaga.nvim",
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	"ray-x/lsp_signature.nvim",

    -- C# LSP (not managed through mason-lspconfig)
    { 
        "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {},
    lazy = false
    },

	-- Which key
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		version = "v2.1.0",
	},

	-- Tmux navigator
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- Smart comments
	"preservim/nerdcommenter",

	-- Auto format
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	},

	-- Git kit
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"tpope/vim-fugitive",
	--"APZelos/blamer.nvim",
	"lewis6991/gitsigns.nvim",
	{ "sindrets/diffview.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	--"topaxi/gh-actions.nvim",

	-- Add persistence to files
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
	},

	-- DAP-debugger
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
            "rcarriga/cmp-dap",
		}
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-jest",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- Zen mode (focus on window)
	"folke/zen-mode.nvim",

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		version = "v0.0.10",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cmd /c \"cd app && yarn install\"",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "echasnovski/mini.nvim", optional = true },
		config = function()
			require("render-markdown").setup({})
		end,
	},

	-- Buffer line plugin
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- Find and replace tool
	"MagicDuck/grug-far.nvim",

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
	},

	--{
	--"supermaven-inc/supermaven-nvim",
	--},

	-- Go features
	{
		"olexsmir/gopher.nvim",
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},

	-- Movements upgrade
	"ggandor/leap.nvim",

	-- Resurrect
	"tpope/vim-obsession",

	-- Multi Cursor
	--"mg979/vim-visual-multi",
	--"terryma/vim-multiple-cursors",

	-- Snippets
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
	},
}

require("lazy").setup(plugins, {
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			-- disable unused builtin plugins from neovim
			disabled_plugins = {
				"gzip",
				"health",
				"matchit",
				"netrw",
				"netrwPlugin",
				"rplugin",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zip",
				"zipPlugin",
			},
		},
	},
})

