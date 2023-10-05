local leader = require("utils.map").leader

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
		"echasnovski/mini.clue",
		version = false,
		config = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
		end,
	},
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = false,
				execution_message = {
					message = function()
						return ""
					end,
				},
			})
			require("auto-save").off()
		end,
	},
}
