local leader = require("utils.map").leader

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = function()
				if vim.g.disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
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
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        tsx = { "prettier" },
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
		vim.g.disable_autoformat = true

		vim.api.nvim_create_user_command("FToggle", function()
			require("utils.utils").format_toggle()
		end, {
			desc = "Format on save toggle",
		})

		leader("w", '<cmd>lua require("conform").format({ lsp_fallback = true })<cr>', "Write with formatting")
	end,
}
