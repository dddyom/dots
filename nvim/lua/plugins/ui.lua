return {
	-----------------------------------------------------------------------------
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{ "MunifTanjim/nui.nvim", lazy = false },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	-----------------------------------------------------------------------------
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {
					CursorLine = { bg = "#0F1D3E", fg = "" },
					CurSearch = { fg = "#0A0E14", bg = "#F07178" },
					WildMenu = { fg = "#0A0E14", bg = "#FFCC66" },
					Visual = { fg = "#0A0E14", bg = "#FFCC66" },
					LspInlayHint = { fg = "#464D5E" },
					Pmenu = { bg = "#0F131A", fg = "#BFBDB6" },
					PmenuSel = { bg = "#FFCC66", fg = "#0A0E14" },
				},
			})
			vim.cmd("colorscheme ayu")
		end,
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({ chunk = { enable = true } })
		end,
	},
	-----------------------------------------------------------------------------
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
					lualine_a = {
						{
							"buffers",
							symbols = require("core.icons").buffers,
							fmt = function(name, bufnr)
								if bufnr and bufnr.file then
									if bufnr.file == "" then
										return require("core.icons").buffers.no_name
									end
									return vim.fn.fnamemodify(bufnr.file, ":h:t")
										.. "/"
										.. vim.fn.fnamemodify(bufnr.file, ":t")
								else
									return name
								end
							end,
							max_length = vim.o.columns * 2 / 3,
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = { "fileformat", "filetype" },
					lualine_y = {
						{
							function()
								local session_name = require("core.utils").tmux_session_name()
								if session_name == nil then
									return ""
								else
									return "[ " .. session_name .. " ]"
								end
							end,
							cond = function()
								return os.getenv("TMUX") ~= nil
							end,
						},
					},
					lualine_z = { "location" },
				},

				tabline = {
					lualine_a = {
						{
							function()
								return require("core.utils").get_project_name(vim.fn.getcwd())
							end,
						},
					},
					lualine_b = { { "filename", path = 1 } },
					lualine_y = {
						{
							function()
								return require("arrow.statusline").text_for_statusline_with_icons()
							end,
						},
					},
					lualine_z = { "branch", "searchcount" },
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
			lsp = {
				progress = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"rcarriga/nvim-notify",

		opts = {
			icons = require("core.icons").notify,
			level = 2,
			minimum_width = 50,
			render = "compact",
			stages = "static",
			time_formats = {
				notification = "%T",
				notification_history = "%FT%T",
			},
			timeout = 1000,
			top_down = false,
		},
	},
}
