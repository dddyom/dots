return {
	{
		"tanvirtin/vgit.nvim",
		branch = "v1.0.x",
		event = "VimEnter",
		config = true,

		keys = {
			{ "<leader>g", "", desc = "Git" },
			{ "g[", "<cmd>lua require('vgit').hunk_up()<CR>", desc = "Move to previous hunk" },
			{ "g]", "<cmd>lua require('vgit').hunk_down()<CR>", desc = "Move to next hunk" },
			{ "<leader>gs", "<cmd>lua require('vgit').buffer_hunk_stage()<CR>", desc = "Stage hunk" },
			{ "<leader>gS", "<cmd>lua require('vgit').buffer_stage()<CR>", desc = "Stage buffer" },
			{ "<leader>gu", "<cmd>lua require('vgit').buffer_unstage()<CR>", desc = "Unstage buffer" },
			{ "<leader>gr", "<cmd>lua require('vgit').buffer_hunk_reset()<CR>", desc = "Reset hunk" },
			{ "<leader>gp", "<cmd>lua require('vgit').buffer_hunk_preview()<CR>", desc = "Preview hunk" },
			{ "<leader>gb", "<cmd>lua require('vgit').buffer_blame_preview()<CR>", desc = "Blame preview" },
			{ "<leader>gf", "<cmd>lua require('vgit').buffer_diff_preview()<CR>", desc = "Diff preview" },
			{ "<leader>gf", "<cmd>lua require('vgit').buffer_diff_preview()<CR>", desc = "Diff preview" },
			{ "<leader>gc", "<cmd>lua require('vgit').project_commit_preview()<CR>", desc = "Commit preview" },
			{ "<leader>gh", "<cmd>lua require('vgit').buffer_history_preview()<CR>", desc = "Git log history" },
			{ "<leader>gR", "<cmd>lua require('vgit').buffer_reset()<CR>", desc = "Reset buffer" },
			{ "<leader>gd", "<cmd>lua require('vgit').project_diff_preview()<CR>", desc = "Project diff preview" },
			{ "<leader>gx", "<cmd>lua require('vgit').toggle_diff_preference()<CR>", desc = "Toggle diff preference" },
		},
	},
}
