return {
	"kshenoy/vim-signature",
	{ "otavioschwanck/arrow.nvim", opts = { show_icons = true, leader_key = "m" } },
	-----------------------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		dependencies = { "SirZenith/oil-vcs-status" },
		config = function()
			require("oil").setup({
				win_options = {
					signcolumn = "number",
				},
			})
			require("oil-vcs-status").setup({
				status_symbol = require("core.icons").git,
				status_hl_group = require("core.colors").oil_vcs_status,
			})
		end,
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
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
  -- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
	},
	-----------------------------------------------------------------------------
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup()
			fzf.register_ui_select()
		end,
		-- stylua: ignore
		keys = {
			{ "<leader>f", "", desc = "Find" },
			{ "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files" },
			{ "<leader>fw", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Find by word" },
			{ "<leader>s", "<cmd>lua require('fzf-lua').blines()<CR>", desc = "Find in buffer" },
			{ "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", desc = "Find help tags" },
			{ "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions({jump_to_single_result = true})<CR>", desc = "Lsp definitions" },
			{ "gd", "<cmd>lua require('fzf-lua').lsp_definitions({jump_to_single_result = true})<CR>", desc = "Lsp definitions" },
			{ "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references({jump_to_single_result = true})<CR>", desc = "Lsp references" },
			{ "<leader>fa", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Lsp code actions" },
		},
	},
}
