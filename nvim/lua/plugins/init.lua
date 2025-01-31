return {
	"nvim-lua/plenary.nvim",
	"lambdalisue/vim-suda",
	-----------------------------------------------------------------------------
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({ manual = true })
		end,
	},
	{
		"ada0l/obsidian",
		lazy = "VeryLazy",
		keys = {
			{ "<leader>nn", '<cmd>lua require("obsidian").new_note_prompt()<cr>', desc = "New note" },
			{ "<leader>fn", '<cmd>lua require("obsidian").note_picker()<cr>', desc = "Note picker" },
			{
				"gf",
				function()
					if require("obsidian").found_wikilink_under_cursor() ~= nil then
						return '<cmd>lua require("obsidian").go_to()<CR>'
					else
						return "gf"
					end
				end,
				noremap = false,
				expr = true,
			},
		},
		opts = { vaults = { { dir = "~/.sync/notes" } } },
	},

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
