return {
	-----------------------------------------------------------------------------
	-- Рендер md прямо в буфере: заголовки, чекбоксы, таблицы, code-блоки
	-----------------------------------------------------------------------------
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			completions = { lsp = { enabled = true } },
			heading = { sign = false },
			code = { sign = false, width = "block", min_width = 60 },
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
		},
	},

	-----------------------------------------------------------------------------
	-- Live-preview в браузере: :MarkdownPreview / :MarkdownPreviewToggle
	-----------------------------------------------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = { "markdown" },
		build = "cd app && ./install.sh",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_theme = "dark"
		end,
	},
}
