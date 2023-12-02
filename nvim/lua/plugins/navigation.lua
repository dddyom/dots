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
		"ThePrimeagen/harpoon",
		config = true,
		keys = {
			{ "<m-m>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "marks" },
			{ "M", '<cmd>lua require("harpoon.mark").add_file()<cr>', "add mark" },
			{ "<m-p>", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "prev mark" },
			{ "<m-n>", '<cmd>lua require("harpoon.ui").nav_next()<cr>', "next mark" },
			{ "<m-1>", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "harpoon file 1" },
			{ "<m-2>", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "harpoon file 2" },
			{ "<m-3>", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "harpoon file 3" },
			{ "<m-4>", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', "harpoon file 4" },
			{ "<m-5>", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', "harpoon file 5" },
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
}
