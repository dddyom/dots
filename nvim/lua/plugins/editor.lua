return {
	-----------------------------------------------------------------------------
	"gennaro-tedesco/nvim-peekup",
	"sheerun/vim-polyglot",
	{ "yamatsum/nvim-cursorline", config = true },
	{ "vladdoster/remember.nvim", config = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-----------------------------------------------------------------------------
	{
		"Wansmer/treesj",
		keys = { { "<space>j", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/join" } },
		config = true,
		opts = { use_default_keymaps = false },
	},
	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.bufremove",
		opts = {},
		keys = {
			{ "<leader>b", "", desc = "Buffer" },
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete",
			},
		},
	},
	-----------------------------------------------------------------------------
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<Leader>z", "<cmd>ZenMode<CR>", noremap = true, desc = "Zen Mode" },
		},
		opts = {
			plugins = {
				gitsigns = { enabled = true },
				tmux = { enabled = vim.env.TMUX ~= nil },
			},
		},
	},
	-----------------------------------------------------------------------------
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		init = function()
			vim.keymap.set("n", "<leader>r", "", {
				desc = "replace (spectre)",
			})
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
			vim.keymap.set("n", "<leader>rR", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("v", "<leader>rR", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("n", "<leader>rr", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
	-----------------------------------------------------------------------------
	{
		"nil70n/floating-help",
		opts = { border = "double", ratio = 0.8 },
	},
	-----------------------------------------------------------------------------
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({ mapping = { "jk", "jj", "kk", "kj" } })
		end,
	},
	-----------------------------------------------------------------------------
	{
		"bloznelis/before.nvim",
		config = function()
			local before = require("before")
			before.setup()
			vim.keymap.set("n", "<C-o>", before.jump_to_last_edit, {})
			vim.keymap.set("n", "<C-i>", before.jump_to_next_edit, {})
		end,
	},
	-----------------------------------------------------------------------------
}
