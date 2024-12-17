return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		main = "nvim-treesitter.configs",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
			{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
		},
		opts = {
			highlight = { enable = true, disable = { "markdown" } },
			indent = { enable = true, disable = { "markdown" } },
			ensure_installed = {
				"python",
				"bash",
				"css",
				"html",
				"json",
				"htmldjango",
				"http",
				"javascript",
				"lua",
				"make",
				"regex",
				"rust",
				"tsx",
				"typescript",
				"dockerfile",
			},
		},
	},
	{
		"aaronik/treewalker.nvim",
		config = function()
			require("treewalker").setup({ { highlight = true } })
			vim.api.nvim_set_keymap("n", "<Down>", ":Treewalker Down<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Up>", ":Treewalker Up<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Left>", ":Treewalker Left<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Right>", ":Treewalker Right<CR>", { noremap = true })
		end,
	},
	{ "tronikelis/ts-autotag.nvim", opts = {}, event = "VeryLazy" },
}
