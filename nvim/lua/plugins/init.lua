return {
	-- Библиотека Lua-функций для Neovim (требуется многими плагинами)
	"nvim-lua/plenary.nvim",

	-----------------------------------------------------------------------------
	-- Автоматическое определение корня проекта
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({ manual = true })
		end,
	},

	-----------------------------------------------------------------------------
	-- Интеграция с Obsidian (менеджер заметок)
	{
		"ada0l/obsidian",
		lazy = "VeryLazy",
		keys = {
            -- stylua: ignore start
			{ "<leader>nn", function() require("obsidian").new_note_prompt() end, desc = "Create new note" },
			{ "<leader>fn", function() require("obsidian").note_picker() end, desc = "Open note picker" },
			{ "gf", function() if require("obsidian").found_wikilink_under_cursor() ~= nil then require("obsidian").go_to() else return "gf" end end, noremap = false, expr = true },
			-- stylua: ignore end
		},
		opts = { vaults = { { dir = "~/.sync/notes" } } },
	},

	-----------------------------------------------------------------------------
	-- Подсказки при нажатии клавиш (аналог WhichKey)
	{
		"echasnovski/mini.clue",
		version = false,
		init = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Лидер-клавиши
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Встроенное автодополнение
					{ mode = "i", keys = "<C-x>" },

					-- Клавиши `g`
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Метки
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Регистры
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
