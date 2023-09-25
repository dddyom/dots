local leader = require("utils.map").leader

return {
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {
					CursorLine = { bg = "#232A4C", fg = "" },
					CurSearch = { fg = "#0A0E14", bg = "#F07178" },
					WildMenu = { fg = "#0A0E14", bg = "#FFCC66" },
					TelescopePromptTitle = { fg = "#0A0E14", bg = "#F07178" },
				},
			})
			vim.cmd("colorscheme ayu")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
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
					icons_enabled = false,
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
					lualin,
				},
				inactive_sections = {
					lualine_c = {},
				},
				winbar = {
					lualine_a = {
						{
							function()
								return require("utils.utils").get_diffview_title()
							end,
							cond = function()
								return require("utils.utils").is_show_diffview_title()
							end,
						},
					},
				},
			})
		end,
	},
	{
		"Tyler-Barham/floating-help.nvim",
		config = function()
			local fh = require("floating-help")

			fh.setup({
				width = 140,
				height = 0.9,
				position = "C",
			})

			local function cmd_abbrev(abbrev, expansion)
				local cmd = "cabbr "
					.. abbrev
					.. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
					.. expansion
					.. '" : "'
					.. abbrev
					.. '")<CR>'
				vim.cmd(cmd)
			end
			cmd_abbrev("h", "FloatingHelp")
			cmd_abbrev("help", "FloatingHelp")
			cmd_abbrev("helpc", "FloatingHelpClose")
			cmd_abbrev("helpclose", "FloatingHelpClose")
		end,
	},
	{
		"folke/zen-mode.nvim",
		opts = {},
		config = function()
			leader("z", "<cmd>ZenMode<CR>", "zen mode")
		end,
	},
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},
}
