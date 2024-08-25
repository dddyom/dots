return {
	"nvim-lua/plenary.nvim",
	-----------------------------------------------------------------------------
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({ manual = true })
		end,
	},
}
