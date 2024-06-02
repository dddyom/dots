return {

	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"tpope/vim-fugitive",
		event = { "VimEnter" },
		keys = {
			{ "<leader>g", "", desc = "git" },
			{ "<leader>gg", "<cmd>Git<cr>", desc = "git" },
			{ "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "git diff" },
		},
	},
	-----------------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = { signs = require("core.icons").git.signs },
		keys = {
			{ "g]", "<cmd>Gitsigns next_hunk<cr>", desc = "next git hunk" },
			{ "g[", "<cmd>Gitsigns prev_hunk<cr>", desc = "next git hunk" },
			{ "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", desc = "stage hunk" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "undo stage hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "reset hunk" },
			{ "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "reset buffer" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "preview hunk" },
			{ "<leader>gc", "<cmd>Gitsigns blame_line<cr>", desc = "line blame" },
		},
	},
}
