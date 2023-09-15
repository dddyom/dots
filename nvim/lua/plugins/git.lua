local leader = require("utils.map").leader
return {
	"sindrets/diffview.nvim",
	config = function()
		local actions = require("diffview.actions")
		vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("rafi_diffview", {}),
			pattern = "diffview:///panels/*",
			callback = function()
				vim.opt_local.cursorline = true
				vim.opt_local.winhighlight = "CursorLine:WildMenu"
			end,
		})
		require("diffview").setup({
			default = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
			keymaps = {
				view = {
					{ "n", "q", "<cmd>DiffviewClose<CR>" },
					{ "n", "<c-e>", actions.toggle_files },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<CR>" },
					{ "n", "o", actions.focus_entry },
					{ "n", "gf", actions.goto_file },
					{ "n", "<C-r>", actions.refresh_files },
				},
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<CR>" },
					{ "n", "o", actions.focus_entry },
				},
			},
		})
		leader("gd", "<cmd>DiffviewOpen<cr>", "Diffview open")
		leader("gh", "<cmd>DiffviewFileHistory %<cr>", "File history")
	end,
}, { "lewis6991/gitsigns.nvim", config = true }, { "akinsho/git-conflict.nvim", version = "*", config = true }, {
	"FabijanZulj/blame.nvim",
	config = function()
		leader("gc", "<cmd>ToggleBlame window<cr>", "Show commits")
	end,
}
