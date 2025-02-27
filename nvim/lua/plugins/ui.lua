return {
	-----------------------------------------------------------------------------
	-- Поддержка иконок для плагинов и файловых типов
	{ "nvim-tree/nvim-web-devicons", lazy = false },

	-- Фреймворк для создания UI-компонентов в Neovim
	{ "MunifTanjim/nui.nvim", lazy = false },

	-- Подсветка цветов внутри кода (например, `#FF0000` будет подсвечен красным)
	{ "brenoprata10/nvim-highlight-colors", config = true },
	-----------------------------------------------------------------------------
	-- Цветовая схема Ayu с пользовательскими настройками
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
					LineNr = { fg = "#464D5E" },
					Pmenu = { bg = "#0F131A", fg = "#BFBDB6" },
					PmenuSel = { bg = "#FFCC66", fg = "#0A0E14" },
				},
			})
			vim.cmd("colorscheme ayu")
		end,
	},

	-----------------------------------------------------------------------------
	-- Статусная строка Lualine с кастомной темой и отображением буферов
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local custom_ayu = require("lualine.themes.ayu")
			custom_ayu.normal.c.bg = "#0000000" -- Прозрачный фон

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
							"filename",
							symbols = require("core.icons").buffers,
						},
					},
					lualine_b = {
						{
							"diagnostics",
							symbols = require("core.icons").diagnostics,
						},
					},

					lualine_c = {},
					lualine_x = { "fileformat", "filetype" },

					-- Отображение имени текущей TMUX-сессии, если TMUX запущен
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

				-- Верхняя панель с названием проекта и буферов
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
}
