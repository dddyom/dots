return {
	-----------------------------------------------------------------------------
  "tpope/vim-rsi",
	{ "yamatsum/nvim-cursorline", config = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-----------------------------------------------------------------------------
	{
		"chentoast/marks.nvim",
		config = true,
		event = "VeryLazy",
		keys = {
			{ "<leader>mm", "<Cmd>MarksListBuf<CR>", desc = "marks: list buffer marks" },
			{ "<leader>mg", "<Cmd>MarksListBuf<CR>", desc = "marks: list global marks" },
			{ "<leader>mb", "<Cmd>MarksListBuf<CR>", desc = "marks: list bookmark marks" },
			{ "m/", "<cmd>MarksListAll<CR>", desc = "Marks from all opened buffers" },
			{ "<leader>mt", "<cmd>MarksToggleSigns<cr>", desc = "Toggle marks" },
			{ "<leader>mc", "<cmd>delm! | delm A-Z0-9<cr>", desc = "Clear all marks" },
			-- { 'm', '<Plug>(Marks-set)', '<Plug>(Marks-toggle)' },
		},
		opts = {
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			bookmark_1 = { sign = "󰈼" }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀
			default_mappings = false, -- whether to map keybinds or not. default true
			builtin_marks = {}, -- which builtin marks to show. default {}
			cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
			force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
			-- bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
			--   sign = "⚑",
			--   virt_text = "hello world",
			-- },
			mappings = {
				set_next = "m,",
				next = "m]",
				preview = "m;",
				set_bookmark0 = "m0",
				prev = false, -- pass false to disable only this default mapping
				annotate = "m<Space>",
			},
		},
	},
	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.bufremove",
		opts = {},
		-- stylua: ignore
		keys = {
			{ '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer', },
		},
	},
	-----------------------------------------------------------------------------
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<Leader>zz", "<cmd>ZenMode<CR>", noremap = true, desc = "Zen Mode" },
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
		"roobert/search-replace.nvim",
		event = "BufRead",
		init = function()
			require("search-replace").setup()
			vim.o.inccommand = "split"
		end,
		keys = {
			{ "<leader>r", "", "Replace" },
			{
				"<leader>rr",
				"<cmd>SearchReplaceSingleBufferCWord<cr>",
				"Replace in current buffer (word under cursor)",
			},
			{ "<leader>rR", "<cmd>SearchReplaceMultiBufferCWord<cr>", "Replace in all buffers" },
			{
				"<leader>re",
				"<cmd>SearchReplaceSingleBufferCExpr<cr>",
				"Replace in current buffer (expession under cursor)",
			},
			{ "<leader>rE", "<cmd>SearchReplaceMultiBufferCExpr<cr>", "Replace in current buffer" },
		},
	},
}
