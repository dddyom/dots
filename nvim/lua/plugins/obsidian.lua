-- Путь vault'а используется и в obsidian.nvim, и в :MdToVault (autocmds.lua)
vim.g.obsidian_vault = vim.fn.expand("~/.sync/notes")

local function obsidian_new()
	vim.ui.input({ prompt = "Obsidian new note: " }, function(name)
		if name and #name > 0 then
			vim.cmd("ObsidianNew " .. name)
		end
	end)
end

return {
	-- obsidian.nvim не поддерживает snacks.picker; mappings подогнаны под snacks-стиль.
	{
		"echasnovski/mini.pick",
		lazy = true,
		opts = {
			mappings = {
				move_down = "<C-j>",
				move_up = "<C-k>",
				scroll_down = "<C-d>",
				scroll_up = "<C-u>",
				delete_left = "", -- <C-u> отдан scroll_up; для стирания — Backspace / <C-w>
			},
		},
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.pick" },
		cmd = {
			"ObsidianQuickSwitch",
			"ObsidianNew",
			"ObsidianToday",
			"ObsidianYesterday",
			"ObsidianTomorrow",
			"ObsidianOpen",
			"ObsidianSearch",
			"ObsidianBacklinks",
			"ObsidianRename",
			"ObsidianFollowLink",
		},
		keys = {
			-- stylua: ignore start
			{ "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian: quick switch" },
			{ "<leader>on", obsidian_new,                   desc = "Obsidian: new note" },
			{ "<leader>od", "<cmd>ObsidianToday<CR>",       desc = "Obsidian: today's daily" },
			{
				"<leader>op",
				function()
					local project = require("core.projects").find_by_path(vim.fn.getcwd())
					if not project then
						vim.notify("Obsidian: cwd не в реестре проектов (core.projects)", vim.log.levels.WARN)
						return
					end
					local dir = vim.g.obsidian_vault .. "/projects/" .. project.name
					if vim.fn.isdirectory(dir) == 0 then
						vim.notify("Obsidian: " .. dir .. " не существует", vim.log.levels.WARN)
						return
					end
					require("mini.pick").builtin.files({}, { source = { cwd = dir, name = "notes: " .. project.name } })
				end,
				desc = "Obsidian: notes for current project",
			},
			-- stylua: ignore end
		},
		opts = {
			workspaces = {
				{ name = "notes", path = vim.g.obsidian_vault },
			},
			picker = { name = "mini.pick" },
			completion = {
				nvim_cmp = false,
				blink = true,
				min_chars = 2,
			},
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
			},
			-- Захочешь шаблоны — создай ~/.sync/notes/templates/ и добавь
			-- templates = { folder = "templates", date_format = ..., time_format = ... }
			ui = { enable = false }, -- рендер берёт на себя render-markdown.nvim
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
			new_notes_location = "current_dir",
		},
	},
}
