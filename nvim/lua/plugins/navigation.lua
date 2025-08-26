return {
	-----------------------------------------------------------------------------
	-- Быстрая навигация по файлам, буферам и командам
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			always_show_path = true,
			separate_by_branch = true,
			leader_key = ";",
			buffer_leader_key = "m",
		},
	},
	-----------------------------------------------------------------------------
	-- Файловый менеджер внутри буфера с поддержкой Git-статуса
	{
		"stevearc/oil.nvim",
		dependencies = { "SirZenith/oil-vcs-status", { "JezerM/oil-lsp-diagnostics.nvim", opts = {} } },
		config = function()
			require("oil").setup({
				win_options = {
					signcolumn = "number", -- Отображение знаков слева от номера строки
				},
				view_options = {
					show_hidden = true, -- Показывать скрытые файлы
					is_always_hidden = function(name, _)
						return name == ".." or name == "__pycache__"
					end,
				},
			})
			require("oil-vcs-status").setup({
				status_symbol = require("core.icons").git, -- Иконки для отображения статуса Git
				status_hl_group = require("core.colors").oil_vcs_status, -- Подсветка статусов Git
			})

			-- Автоматическая обработка переименования файлов
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						---@diagnostic disable: undefined-global
						Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
						---@diagnostic enable: undefined-global
					end
				end,
			})
		end,
		keys = {
            -- stylua: ignore
			{ "``", function() require("oil").open_float() end, desc = "Open Oil" },
		},
	},

	-----------------------------------------------------------------------------
	-- Навигация между окнами Neovim и Tmux
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		keys = {
            -- stylua: ignore start
			{ "<M-h>", function() vim.cmd("TmuxNavigateLeft") end, mode = { "n", "t" }, silent = true, desc = "Jump to left pane" },
			{ "<M-j>", function() vim.cmd("TmuxNavigateDown") end, mode = { "n", "t" }, silent = true, desc = "Jump to lower pane" },
			{ "<M-k>", function() vim.cmd("TmuxNavigateUp") end, mode = { "n", "t" }, silent = true, desc = "Jump to upper pane" },
			{ "<M-l>", function() vim.cmd("TmuxNavigateRight") end, mode = { "n", "t" }, silent = true, desc = "Jump to right pane" },
			-- stylua: ignore end
		},
	},

	-----------------------------------------------------------------------------
	-- Улучшенная подсветка поиска (аналог EasyMotion)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
            -- stylua: ignore start
			{ "c", mode = { "n" }, function() require("flash").jump() end, desc = "Flash Jump" },
			{ "C", mode = { "n" }, function() require("flash").treesitter() end, desc = "Flash Treesitter Search" },
			-- stylua: ignore end
		},
	},

	{
		"dmtrKovalenko/fff.nvim",
		build = "cargo build --release",
		opts = {},
		-- stylua: ignore start
		keys = { { "ff", function() require("fff").find_files() end, desc = "Find files", } },
		-- stylua: ignore end
	},
}
