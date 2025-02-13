return {
	-----------------------------------------------------------------------------
	"sheerun/vim-polyglot",
	{ "yamatsum/nvim-cursorline", config = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "OXY2DEV/markview.nvim", lazy = false },
	-----------------------------------------------------------------------------
	-- stylua: ignore
	{ "axkirillov/hbac.nvim", config = function() require("hbac").setup({ threshold = 7 }) end },
	-----------------------------------------------------------------------------
	{
		"Wansmer/treesj",
		keys = { { "<space>j", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/join" } },
		config = true,
		opts = { use_default_keymaps = false },
	},
	-----------------------------------------------------------------------------
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		init = function()
            -- stylua: ignore
			vim.keymap.set("n", "<leader>r", "", { desc = "replace (spectre)" })
            -- stylua: ignore
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
            -- stylua: ignore
			vim.keymap.set("n", "<leader>rR", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
            -- stylua: ignore
			vim.keymap.set("v", "<leader>rR", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
            -- stylua: ignore
			vim.keymap.set("n", "<leader>rr", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })
		end,
	},
}
