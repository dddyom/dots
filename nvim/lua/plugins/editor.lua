return {
	-----------------------------------------------------------------------------
	-- Подчеркивание слова под курсором
	{ "yamatsum/nvim-cursorline", config = true },
	-----------------------------------------------------------------------------
	-- Разделение и объединение конструкций в коде (например, массивов, объектов, условий)
	{
		"Wansmer/treesj",
		keys = {
			-- stylua: ignore
			{ "<space>j", function() require("treesj").toggle() end, desc = "Toggle split/join" },
		},
		config = true,
		opts = { use_default_keymaps = false },
	},
	-----------------------------------------------------------------------------
	-- Поиск и замена с предварительным просмотром
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		init = function()
			-- stylua: ignore start
			vim.keymap.set("n", "<leader>r", "", { desc = "Replace (Spectre)" })
			vim.keymap.set("n", "<leader>S", function() require("spectre").toggle() end, { desc = "Toggle Spectre" })
			vim.keymap.set("n", "<leader>rR", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Search current word" })
			vim.keymap.set("v", "<leader>rR", function() vim.cmd("esc") require("spectre").open_visual() end, { desc = "Search current word" })
			vim.keymap.set("n", "<leader>rr", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Search in current file" })
			-- stylua: ignore end
		end,
	},
}
