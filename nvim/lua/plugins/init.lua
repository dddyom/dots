return {
	"nvim-lua/plenary.nvim",
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
}
