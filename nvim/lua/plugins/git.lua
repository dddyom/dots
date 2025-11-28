return {
	{
		"tanvirtin/vgit.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		branch = "v1.0.x",
		event = "VimEnter",
		config = true,

		keys = {
			-- stylua: ignore start
			{ "<leader>g", "", desc = "Git" },
			{ "g[", function() require("vgit").hunk_up() end, desc = "Go to previous hunk" },
			{ "g]", function() require("vgit").hunk_down() end, desc = "Go to next hunk" },
			{ "<leader>gs", function() require("vgit").buffer_hunk_stage() end, desc = "Stage hunk" },
			{ "<leader>gS", function() require("vgit").buffer_stage() end, desc = "Stage buffer" },
			{ "<leader>gu", function() require("vgit").buffer_unstage() end, desc = "Unstage buffer" },
			{ "<leader>gr", function() require("vgit").buffer_hunk_reset() end, desc = "Reset hunk" },
			{ "<leader>gp", function() require("vgit").buffer_hunk_preview() end, desc = "Preview hunk" },
			{ "<leader>gb", function() require("vgit").buffer_blame_preview() end, desc = "Show blame preview" },
			{ "<leader>gf", function() require("vgit").buffer_diff_preview() end, desc = "Show buffer diff" },
			{ "<leader>gc", function() require("vgit").project_commit_preview() end, desc = "Show commit preview" },
			{ "<leader>gh", function() require("vgit").buffer_history_preview() end, desc = "Show buffer history" },
			{ "<leader>gR", function() require("vgit").buffer_reset() end, desc = "Reset buffer to last commit" },
			{ "<leader>gd", function() require("vgit").project_diff_preview() end, desc = "Show project diff" },
			{ "<leader>gx", function() require("vgit").toggle_diff_preference() end, desc = "Toggle diff view" },
			-- stylua: ignore end
		},
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
}
