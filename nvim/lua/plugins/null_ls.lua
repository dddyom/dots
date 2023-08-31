return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		local formatting = null_ls.builtins.formatting
		local code_actions = null_ls.builtins.code_actions
		local diagnostics = null_ls.builtins.diagnostics
		local sources = {
			code_actions.eslint_d,
			code_actions.shellcheck,
			code_actions.gitsigns,

			diagnostics.dotenv_linter,
			diagnostics.djlint,
			diagnostics.eslint_d,
			diagnostics.zsh,
			-- diagnostics.pylint,

			formatting.autopep8,
			formatting.stylua,
			formatting.eslint_d,
			formatting.prettier,
			formatting.djhtml,
			formatting.jq,
			formatting.sqlfluff,
			formatting.shellharden,
		}

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end

		null_ls.setup({
			sources = sources,
			on_attach = on_attach,
		})
	end,
}
