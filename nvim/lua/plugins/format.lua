local leader = require("utils.map").leader
local leader_v = require("utils.map").leader_v

return {
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
			"jeetsukumaran/vim-pythonsense",
			"JoosepAlviste/nvim-ts-context-commentstring",
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
				matchup = {
					enable = true,
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				autotag = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },
			})
			require("ts_context_commentstring").setup({})
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
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
		"willothy/moveline.nvim",
		build = "make",
		config = function()
			leader("m", "", "Move line")
			leader("mk", "<cmd>lua require('moveline').up()<cr>", "Move line up")
			leader("mj", "<cmd>lua require('moveline').down()<cr>", "Move line down")

			leader_v("m", "", "Move block")
			leader_v("mk", "<cmd>lua require('moveline').block_up()<cr>", "move block up")
			leader_v("mj", "<cmd>lua require('moveline').block_down()<cr>", "move block down")
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		config = true,
	},
}
