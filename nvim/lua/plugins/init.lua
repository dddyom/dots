local leader = require("utils.map").leader
local map_n = require("utils.map").n

return {
	"nvim-lua/plenary.nvim",
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({ fallback_to_parent = false })
		end,
	},
	{
		"linty-org/readline.nvim",
		config = function()
			local readline = require("readline")
			vim.keymap.set("!", "<M-f>", readline.forward_word)
			vim.keymap.set("!", "<M-b>", readline.backward_word)
			vim.keymap.set("!", "<M-a>", readline.beginning_of_line)
			vim.keymap.set("!", "<M-e>", readline.end_of_line)
			vim.keymap.set("!", "<M-d>", readline.kill_word)
			vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
			vim.keymap.set("!", "<M-w>", readline.unix_word_rubout)
			vim.keymap.set("!", "<M-k>", readline.kill_line)
			vim.keymap.set("!", "<M-u>", readline.backward_kill_line)
		end,
	},

	{
		"kwkarlwang/bufresize.nvim",
		config = function()
			require("bufresize").setup({
				register = { resize = { keys = {}, trigger_events = { "VimResized" }, increment = 5 } },
			})
			leader("H", "20<C-w>>", "Resize right")
			leader("L", "20<C-w><", "Resize left")
			leader("J", "10<C-w>+", "Resize down")
			leader("K", "10<C-w>-", "Resize up")
			leader("O", "<C-w>|<C-w>_", "Resize to max")
			leader("=", "<C-w>=", "Resize to default")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			local wk = require("which-key")
			wk.setup({
				window = { border = "single", winblend = 20 },
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
			})
			wk.register(require("utils.map").prefixes)
		end,
	},
}
