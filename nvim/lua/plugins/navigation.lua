return {
	-----------------------------------------------------------------------------
	-- Arrow: быстрые маркеры/прыжки по файлам и буферам
	{
		"otavioschwanck/arrow.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			show_icons = true,
			always_show_path = true,
			separate_by_branch = true,
			leader_key = ";",
			buffer_leader_key = "m",
		},
	},

	-----------------------------------------------------------------------------
	-- Oil: файловый менеджер в виде буфера
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SirZenith/oil-vcs-status",
		},
		config = function()
			require("oil").setup({
				win_options = {
					signcolumn = "number",
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == "__pycache__"
					end,
				},
				float = { padding = 0, win_options = { winblend = 20 } },
			})

			require("oil-vcs-status").setup({
				status_hl_group = require("core.colors").oil_vcs_status,
			})

			-- При переименовании файлов обновлять ссылки через Snacks
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
					end
				end,
			})
		end,
		keys = {
            -- stylua: ignore
			{ "`", function() require("oil").open_float() end, desc = "Open Oil" },
		},
	},

	-----------------------------------------------------------------------------
	-- Навигация между tmux / nvim сплитами
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		keys = {
            -- stylua: ignore start
			{ "<M-h>", function() vim.cmd("TmuxNavigateLeft") end,  mode = { "n", "t" }, silent = true, desc = "Jump to left pane" },
			{ "<M-j>", function() vim.cmd("TmuxNavigateDown") end,  mode = { "n", "t" }, silent = true, desc = "Jump to lower pane" },
			{ "<M-k>", function() vim.cmd("TmuxNavigateUp") end,    mode = { "n", "t" }, silent = true, desc = "Jump to upper pane" },
			{ "<M-l>", function() vim.cmd("TmuxNavigateRight") end, mode = { "n", "t" }, silent = true, desc = "Jump to right pane" },
			-- stylua: ignore end
		},
	},

	-----------------------------------------------------------------------------
	-- Flash: расширенный поиск/прыжки
	{
		"folke/flash.nvim",
		opts = {
			highlight = {
				backdrop = false,
			},
			jump = {
				autojump = true,
				nohlsearch = true,
			},
			labels = "asdfqwerzxcv",
			modes = {
				char = { enabled = false },
				search = {
					enabled = true,
					highlight = { backdrop = false },
					jump = { autojump = false },
				},
			},
			prompt = { win_config = { border = "none" } },
			search = { wrap = true },
		},
	},
}
