return {
	"nvimdev/guard.nvim",
	dependencies = { "nvimdev/guard-collection" },
	config = function()
		local ft = require("guard.filetype")

		ft("lua"):fmt("stylua")
		ft("python"):fmt({
			cmd = "ruff",
			args = {
				"--config",
				'format.quote-style="preserve"',
				"--config",
				"line-length=128",
				"format",
			},
			fname = true,
		})
		ft("javascript", "typescript", "typescriptreact", "tsx"):fmt("prettier")
		ft("rust"):fmt("rustfmt")
		ft("html", "htmldjango"):fmt("djhtml")
		ft("css", "yaml", "markdown"):fmt("prettier")
		ft("json"):fmt("jq")
		ft("dart"):fmt("dart")
		vim.g.guard_config = {
			fmt_on_save = false,
			lsp_as_default_formatter = false,
			-- whether or not to save the buffer after formatting
			save_on_fmt = true,
			auto_lint = true,
			lint_interval = 500,
		}

		-- 	-- Клавиша для форматирования
		vim.keymap.set("n", "<leader>w", function()
			vim.cmd("Guard fmt")
		end, { noremap = true, silent = true, desc = "Format file" })
	end,
}
