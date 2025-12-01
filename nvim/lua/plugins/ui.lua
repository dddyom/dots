return {
	-----------------------------------------------------------------------------
	-- Подсветка цветов (#fff, rgb(), и т.п.)
	{ "brenoprata10/nvim-highlight-colors", config = true },

	-- Авто-ресайз cmdheight
	{ "jake-stewart/auto-cmdheight.nvim", lazy = false, opts = {} },

	-----------------------------------------------------------------------------
	-- Цветовая схема Ayu + оверрайды
	-----------------------------------------------------------------------------
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {
					CursorLine = { bg = "#0F1D3E", fg = "" },
					CurSearch = { fg = "#0A0E14", bg = "#F07178" },
					WildMenu = { fg = "#0A0E14", bg = "#FFCC66" },

					NonText = { fg = "#707A8C" },
					Visual = { fg = "#0A0E14", bg = "#FFCC66" },
					LspInlayHint = { fg = "#464D5E" },
					LineNr = { fg = "#464D5E" },
					Pmenu = { bg = "#0F131A", fg = "#BFBDB6" },
					PmenuSel = { bg = "#FFCC66", fg = "#0A0E14" },
				},
			})
			vim.cmd("colorscheme ayu")
		end,
	},

	-----------------------------------------------------------------------------
	-- Lualine: статус/таблайн + tmux / project / arrow
	-----------------------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = false },
		config = function()
			local custom_ayu = require("lualine.themes.ayu")
			custom_ayu.normal.c.bg = "#0000000" -- псевдо-прозрачный фон

			require("lualine").setup({
				options = {
					theme = custom_ayu,
					component_separators = "",
					section_separators = "",
				},

				sections = {
					lualine_a = {
						{
							"filename",
							symbols = {
								modified = "󰇤",
								readonly = "",
								unnamed = "",
								newfile = "",
							},
						},
					},
					lualine_b = {
						{
							"diagnostics",
							symbols = {
								{
									error = "✘",
									warn = "󰀪",
									info = "",
									hint = "",
								},
							},
						},
					},

					lualine_c = {},
					lualine_x = { "fileformat", "filetype" },

					-- TMUX-сессия справа, если tmux запущен
					lualine_y = {
						{
							function()
								local session_name = require("core.utils.tmux_session_name").tmux_session_name()
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

				-- Верхняя линия: проект + буферы + arrow + git
				tabline = {
					lualine_a = {
						{
							function()
								return require("core.utils.project_name").get_project_name(vim.fn.getcwd())
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
}
