return {
	-----------------------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		config = true,
		keys = {
			{ "``", "<CMD>lua require('oil').open_float()<CR>", desc = "Open Oil" },
		},
	},
	-----------------------------------------------------------------------------
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		-- stylua: ignore
		keys = {
			{ '<M-h>', '<cmd>TmuxNavigateLeft<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to left pane' },
			{ '<M-j>', '<cmd>TmuxNavigateDown<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to lower pane' },
			{ '<M-k>', '<cmd>TmuxNavigateUp<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to upper pane' },
			{ '<M-l>', '<cmd>TmuxNavigateRight<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to right pane' },
		},
	},
	-----------------------------------------------------------------------------
	{
		"backdround/improved-ft.nvim",
		config = function()
			require("improved-ft").setup({ use_default_mappings = true })
		end,
	},
	-----------------------------------------------------------------------------
	{
		"ibhagwan/fzf-lua",
		config = true,
		keys = {
			{ "<leader>f", "", desc = "Find" },
			{ "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files" },
			{ "<leader>fw", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Find by word" },
			{ "<leader>s", "<cmd>lua require('fzf-lua').blines()<CR>", desc = "Find in buffer" },
			{ "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", desc = "Find help tags" },
			{ "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", desc = "Lsp definitions" },
			{ "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", desc = "Lsp definitions" },
			{ "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", desc = "Lsp references" },
			{ "<leader>fa", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Lsp code actions" },
			{ "<M-CR>", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Lsp code actions" },
		},
	},
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = "m",
		},
	},
}
