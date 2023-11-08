local leader = require("utils.map").leader
return {
	{
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
				hooks = {
					diff_buf_win_enter = function(bufnr, winid, ctx)
						if ctx.layout_name:match("^diff2") then
							if ctx.symbol == "a" then
								vim.opt_local.winhl = table.concat({
									"DiffAdd:DiffviewDiffAddAsDelete",
									"DiffDelete:DiffviewDiffDelete",
								}, ",")
							elseif ctx.symbol == "b" then
								vim.opt_local.winhl = table.concat({
									"DiffDelete:DiffviewDiffDelete",
								}, ",")
							end
						end
					end,
				},
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
					use_icons = false,
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
	},
	{ "lewis6991/gitsigns.nvim", config = true },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()
			leader("c", "", "Git conflict")
			leader("co", "<CMD>GitConflictChooseOurs<CR>", "Ours")
			leader("ct", "<CMD>GitConflictChooseTheirs<CR>", "Theirs")
			leader("cb", "<CMD>GitConflictChooseBoth<CR>", "Both")
			leader("c0", "<CMD>GitConflictChooseNone<CR>", "None")
			leader("cj", "<CMD>GitConflictNextConflict<CR>", "Next")
			leader("ck", "<CMD>GitConflictPrevConflict<CR>", "Prev")
		end,
	},
}
