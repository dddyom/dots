local leader = require("utils.map").leader

return {
	{ "yamatsum/nvim-cursorline", config = true },
	"nvim-tree/nvim-web-devicons",
	{
		"NStefan002/speedtyper.nvim",
		branch = "main",
		cmd = "Speedtyper",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},

	{
		"eandrju/cellular-automaton.nvim",
		config = function()
			leader("]", "<cmd>CellularAutomaton make_it_rain<CR>", "rain")
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
			leader("a", "<cmd>SymbolsOutline<CR>", "code structure")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"m-demare/hlargs.nvim",
		config = function()
			require("hlargs").setup()
		end,
	},

	-- theme
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {
					CursorLine = { bg = "#232A4C", fg = "" },
					CurSearch = { fg = "#0A0E14", bg = "#F07178" },
				},
			})
			vim.cmd("colorscheme ayu")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local navic = require("nvim-navic")
			local custom_ayu = require("lualine.themes.ayu")
			custom_ayu.normal.c.bg = "#0000000"

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = custom_ayu,
					component_separators = "|",
					section_separators = "",
				},
				sections = {
					lualine_a = { { "buffers" } },
					lualine_b = {
						{
							function()
								return navic.get_location()
							end,
							cond = function()
								return navic.is_available()
							end,
						},
					},
					lualine_c = { "diff" },
				},
				tabline = {
					lualine_a = {
						{
							function()
								return require("utils.utils").get_project_name(vim.fn.getcwd())
							end,
						},
					},
					lualine_b = { "branch" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { require("recorder").displaySlots },
					lualine_y = { require("recorder").recordingStatus },
					lualine_z = { "mode", "searchcount" },
				},
				inactive_sections = {
					lualine_c = {},
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				view = "cmdline",
				format = {
					cmdline = { icon = ">" },
					search_down = { icon = "" },
					search_up = { icon = "" },
				},
			},
			messages = {
				view = "mini",
				view_warn = "mini",
				view_error = "mini",
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
