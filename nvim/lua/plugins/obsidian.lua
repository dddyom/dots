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
	-- Picker, нужный obsidian.nvim (snacks.picker им не поддерживается).
	-- Mappings подогнаны под snacks-стиль: <C-j>/<C-k> движение, <C-d>/<C-u> скролл.
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
			-- templates: верни блок templates = { folder = "templates", ... }
			-- если создашь ~/.sync/notes/templates/ и захочешь шаблоны
			-- встроенный UI отключаем — рендером занимается render-markdown.nvim
			ui = { enable = false },
			-- gf по wikilink: пускаем стандартный gf, если под курсором не [[link]]
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
			-- что делать при создании ссылки на несуществующую заметку
			new_notes_location = "current_dir",
		},
	},
}
