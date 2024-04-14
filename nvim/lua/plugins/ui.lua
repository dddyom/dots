return {
	-----------------------------------------------------------------------------
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{ "MunifTanjim/nui.nvim", lazy = false },

	-----------------------------------------------------------------------------
	{
		"wookayin/semshi", -- maintained fork
		ft = "python",
		build = ":UpdateRemotePlugins", -- don't disable `rplugin` in lazy.nvim for this
		init = function()
			vim.g.python3_host_prog = vim.fn.exepath("python3")
			-- better done by LSP
			vim.g["semshi#error_sign"] = false
			vim.g["semshi#simplify_markup"] = false
			vim.g["semshi#mark_selected_nodes"] = false
			vim.g["semshi#update_delay_factor"] = 0.001

			vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
				callback = function()
					vim.cmd([[
						highlight! semshiGlobal gui=italic
						highlight! link semshiImported @lsp.type.namespace
						highlight! link semshiParameter @lsp.type.parameter
						highlight! link semshiParameterUnused DiagnosticUnnecessary
						highlight! link semshiBuiltin @function.builtin
						highlight! link semshiAttribute @field
						highlight! link semshiSelf @lsp.type.selfKeyword
						highlight! link semshiUnresolved @lsp.type.unresolvedReference
						highlight! link semshiFree @comment
					]])
				end,
			})
		end,
	},
	-----------------------------------------------------------------------------
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-----------------------------------------------------------------------------
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {
					CursorLine = { bg = "#232A4C", fg = "" },
					CurSearch = { fg = "#0A0E14", bg = "#F07178" },
					WildMenu = { fg = "#0A0E14", bg = "#FFCC66" },
					Visual = { fg = "#0A0E14", bg = "#FFCC66" },
				},
			})
			vim.cmd("colorscheme ayu")
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
						{ "buffers", symbols = require("core.icons").buffers },
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
					lualine_y = { require("recorder").recordingStatus },
					lualine_z = { "branch", "searchcount" },
				},
				winbar = {
					lualine_a = {
						{
							function()
								return require("core.utils").get_diffview_title()
							end,
							cond = function()
								return require("core.utils").is_show_diffview_title()
							end,
						},
					},
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
