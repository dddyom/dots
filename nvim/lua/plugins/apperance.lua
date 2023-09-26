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
			local custom_ayu = require("lualine.themes.ayu")
			custom_ayu.normal.c.bg = "#0000000"

			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = custom_ayu,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { { "buffers" } },
					lualine_b = {},
					lualine_c = {},
					lualine_x = { "fileformat", "filetype" },
					lualine_y = {
						{
							function()
								local session_name = require("utils.utils").tmux_session_name()
								if session_name == nil then
									return ""
								else
									return "[" .. session_name .. "]"
								end
							end,
							cond = function()
								if os.getenv("TMUX") ~= nil then
									return true
								end
							end,
						},
					},
					lualine_z = { "location" },
				},

				tabline = {
					lualine_a = {
						{
							function()
								return require("utils.utils").get_project_name(vim.fn.getcwd())
							end,
						},
					},
					lualine_b = { { "filename", path = 1 } },
					lualine_y = { "diff", require("recorder").recordingStatus },
					lualine_z = { "branch", "searchcount" },
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
			lsp = {
				progress = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
