return {
	-----------------------------------------------------------------------------
	-- Подсветка слова под курсором
	{ "yamatsum/nvim-cursorline", config = true },

	-----------------------------------------------------------------------------
	-- Split / join структур (списки, объекты и т.п.)
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			-- stylua: ignore
			{ "<space>j", function() require("treesj").toggle() end, desc = "Toggle split/join" },
		},
		opts = { use_default_keymaps = false },
	},

	-----------------------------------------------------------------------------
	-- grug-far: поиск/замена с превью
	{
		"MagicDuck/grug-far.nvim",
		event = "BufRead",
		keys = {
            -- stylua: ignore start
			{ "<leader>r",  function() end, desc = "Replace" },
			{ "<leader>R",  function() require("grug-far").open() end, desc = "Toggle grug-far" },
			-- текущее слово в проекте
			{ "<leader>rR", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search current word in project" },
			-- текущее слово в текущем файле
			{ "<leader>rr", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } }) end, desc = "Search current word in current file" },
			-- выделение в проекте
			{ "<leader>rR", function() require("grug-far").with_visual_selection() end, mode = "v", desc = "Search selected text in project" },
			-- выделение в текущем файле
			{ "<leader>rr", function() require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end, mode = "v", desc = "Search selected text in current file" },
			-- stylua: ignore end
		},
		config = true,
	},
}
