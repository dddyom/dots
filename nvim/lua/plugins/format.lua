return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = false,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black", "autopep8" },
				javascript = { { "prettier" } },

				rust = { "rustfmt" },
				html = { "djhtml" },
				dart = { "dart" },
				css = { "prettier" },
				json = { "jq" },
				yaml = { "prettier" },
				sql = { "sqlfluff" },
				markdown = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				tsx = { "prettier" },
				htmldjango = { "prettier" },
			},
		})

		require("conform.formatters.black").args = {
			"--stdin-filename",
			"$FILENAME",
			"--quiet",
			"-",
			"--skip-string-normalization",
			"--line-length",
			"120",
		}
		vim.g.disable_autoformat = true
		-- stylua: ignore
		vim.api.nvim_set_keymap( "n", "<leader>w", '<cmd>lua require("conform").format({ lsp_fallback = true })<cr>', { noremap = true, silent = true, desc = "format" })
	end,
}
