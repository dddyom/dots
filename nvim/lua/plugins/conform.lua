local leader = require("utils.map").leader

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettier" } },

				rust = { "rustfmt" },
				html = { "djhtml" },

				css = { "prettier" },
				json = { "jq" },
				yaml = { "prettier" },
				sql = { "sqlfluff" },
				markdown = { "prettier" },
			},
		})

		require("conform.formatters.black").args = {
			"--stdin-filename",
			"$FILENAME",
			"--quiet",
			"-",
			"--line-length",
			"120",
		}

		leader("w", '<cmd>lua require("conform").format({ lsp_fallback = true })<cr>', "Write with formatting")
	end,
}

