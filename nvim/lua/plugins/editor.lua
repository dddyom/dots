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
		opts = { use_default_keymaps = false },
	},
	-----------------------------------------------------------------------------
	-- Поиск и замена с предварительным просмотром

	{
		"MagicDuck/grug-far.nvim",
		event = "BufRead",
		keys = {
            -- stylua: ignore start
			{ "<leader>R", function() require("grug-far").open() end, desc = "Toggle grug-far" },
			-- 🔍 Найти текущее слово в проекте
			{ "<leader>rR", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search current word in project" },
			-- 🔍 Найти текущее слово в текущем файле
			{ "<leader>rr", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } }) end, desc = "Search current word in current file" },
			-- 🔍 Найти выделенный текст в проекте
			{ "<leader>rR", function() require("grug-far").with_visual_selection() end, mode = "v", desc = "Search selected text in project" },
			-- 🔍 Найти выделенный текст в текущем файле
			{ "<leader>rr", function() require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end, mode = "v", desc = "Search selected text in current file" },
			-- stylua: ignore end
		},
		config = true,
	},
}
