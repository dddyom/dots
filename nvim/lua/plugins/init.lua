return {
	"nvim-lua/plenary.nvim",
	-----------------------------------------------------------------------------
	{
		"Abstract-IDE/abstract-autocmds",
		lazy = false,
		config = function()
			require("abstract-autocmds").setup({
				auto_resize_splited_window = true,
				remove_whitespace_on_save = true,
				no_autocomment_newline = true,
				clear_last_used_search = true,
				open_file_last_position = true,
				smart_dd = true,
				visually_codeblock_shift = true,
				move_selected_upndown = true,
				highlight_on_yank = { enable = true, opts = { timeout = 300 } },
				go_back_normal_in_terminal = true,
				smart_visual_paste = true,
				dont_suspend_with_cz = true,
				smart_save_in_insert_mode = true,
				scroll_from_center = true,
			})
		end,
	},
	-----------------------------------------------------------------------------
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({ fallback_to_parent = false })
		end,
	},
	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.clue",
		version = false,
		init = function()
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
}
