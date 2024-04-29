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
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Toggle signs" },
			{ "<leader>gc", "<cmd>Gitsigns blame_line<cr>", desc = "Line blame" },
		},
	},
}
