local leader = require("utils.map").leader

return {
	{ "yamatsum/nvim-cursorline", config = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"roobert/search-replace.nvim",
		config = function()
			require("search-replace").setup()
			vim.o.inccommand = "split"
			leader("r", "", "Replace")
			leader("rr", "<cmd>SearchReplaceSingleBufferCWord<cr>", "Replace in current buffer (word under cursor)")
			leader("rR", "<cmd>SearchReplaceMultiBufferCWord<cr>", "Replace in all buffers")
			leader(
				"re",
				"<cmd>SearchReplaceSingleBufferCExpr<cr>",
				"Replace in current buffer (expession under cursor)"
			)
			leader("rE", "<cmd>SearchReplaceMultiBufferCExpr<cr>", "Replace in current buffer")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			{
				"chrisgrieser/nvim-various-textobjs",
				lazy = false,
				opts = { useDefaultKeymaps = true },
			},
		},
		build = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"python",
					"lua",
					"http",
					"json",
					"html",
					"htmldjango",
					"javascript",
					"typescript",
					"css",
					"yaml",
					"sql",
					"regex",
					"bash",
					"dockerfile",
					"tsx",
				},
				highlight = {
					enable = true,
				},
				autotag = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
