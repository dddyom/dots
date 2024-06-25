return {
	-----------------------------------------------------------------------------
	-- "numirias/semshi",
	"sheerun/vim-polyglot",
	{ "yamatsum/nvim-cursorline", config = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "max397574/better-escape.nvim", config = true },
	-----------------------------------------------------------------------------
	{
		"Wansmer/treesj",
		keys = { { "<space>j", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/join" } },
		config = true,
		opts = { use_default_keymaps = false },
	},
	-----------------------------------------------------------------------------
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = { { "<Leader>z", "<cmd>ZenMode<CR>", noremap = true, desc = "Zen Mode" } },
		opts = { plugins = { gitsigns = { enabled = true }, tmux = { enabled = vim.env.TMUX ~= nil } } },
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
