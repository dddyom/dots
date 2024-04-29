return {
	{
		"tpope/vim-fugitive",
		event = { "VimEnter" },
		keys = {
			{ "<leader>g", "", desc = "git" },
			{ "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "git diff" },
			{ "gdh", "<cmd>diffget //2<cr>", desc = "merge from left" },
			{ "gdl", "<cmd>diffget //3<cr>", desc = "merge from right" },
		},
	},
	-----------------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = require("core.icons").git.signs,
		},
		keys = {
			{ "g]", "<cmd>Gitsigns next_hunk<cr>", desc = "next git hunk" },
			{ "g[", "<cmd>Gitsigns prev_hunk<cr>", desc = "next git hunk" },
			{ "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", desc = "stage hunk" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "undo stage hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "reset hunk" },
			{ "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "reset buffer" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Toggle signs" },
			{ "<leader>gc", "<cmd>Gitsigns blame_line<cr>", desc = "Line blame" },
		},
	},
}
