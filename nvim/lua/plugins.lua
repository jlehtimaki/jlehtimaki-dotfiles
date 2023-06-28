local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			style = "tokyonight-night",
		},
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			return require("config.catppuccino")
		end,
	},

	-- lsp / AI / CMP
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"gofumpt",
				"goimports-reviser",
				"pyright",
				"marksman",
				"helm",
				"vtsls",
				"stylua",
				"taplo",
				"tflint",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			return require("config.mason-null-ls")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			return require("config.lsp")
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			return require("config.cmp")
		end,
	},
	{
		"petertriho/cmp-git",
		config = function()
			require("cmp_git").setup()
		end,
	},
	{
		"davidsierradz/cmp-conventionalcommits",
		lazy = false,
	},
	"mfussenegger/nvim-lint",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestions = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"dreamsofcode-io/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				async_api_key_cmd = "bw get password ae19356c-c8e3-4346-86c0-c13229530bc",
			})
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- UI
	"onsails/lspkind.nvim",
	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("config.nvimtree")
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
			vim.g.nvimtree_side = opts.view.side
		end,
	},
	-- fuzzy finding files
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			return require("config.telescope")
		end,
	},
	-- beautify the code
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			return require("config.treesitter")
		end,
	},
	-- notify UE
	{
		"rcarriga/nvim-notify",
		lazy = false,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = function()
			return require("config.notify")
		end,
		config = function()
			require("notify").setup({
				background_colour = "#000001",
			})
		end,
	},
	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- colorizer, show colors in code
	{
		"NvChad/nvim-colorizer.lua",
		config = true,
	},
	-- prettier UI
	{
		"stevearc/dressing.nvim",
		lazy = false,
	},
	-- buffer lines
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			return require("config.bufferline")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			return require("config.lualine")
		end,
	},
	-- nicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			return require("config.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"SmiteshP/nvim-navic",
		lazy = false,
		config = function()
			return require("config.navic")
		end,
	},

	-- Utils
	-- lazygit
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- match pairs
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- setup cmp for autopairs
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- comment helper
	{
		"numToStr/Comment.nvim",
		keys = { "gcc", "gbc" },
		config = true,
	},

	-- which key to press
	{
		"folke/which-key.nvim",
		lazy = false,
		keys = { "<leader>", '"', "'", "`", "c", "v" },
		config = true,
	},
	-- vim navigation in tmux
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- show search results in file
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			return require("config.hlslens")
		end,
	},
	-- hop to next target
	{
		"phaazon/hop.nvim",
		lazy = false,
		config = function()
			return require("config.hop")
		end,
	},
	-- terminal
	{
		"NvChad/nvterm",
		config = function(_, opts)
			require("nvterm").setup(opts)
		end,
	},
	-- repeat
	{
		"tpope/vim-repeat",
		lazy = false,
	},
	-- help noticing blanklines
	{
		"lukas-reineke/indent-blankline.nvim",
		config = true,
	},
	-- search and replace all
	{
		"nvim-pack/nvim-spectre",
	},
	-- search from file and leap
	{
		"ggandor/leap.nvim",
		config = function()
			return require("config.leap")
		end,
	},
	-- highlight all searhes
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	-- better trouble listings
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		config = function(_, opts)
			require("trouble").setup(opts)
		end,
	},
	-- TODO comment highlight
	{
		"folke/todo-comments.nvim",
	},
	-- terminal
	{
		-- amongst your other plugins
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			config = true,
		},
		-- surround
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
	},
}

local opts = {}

require("lazy").setup(plugins, opts)
