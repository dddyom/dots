local function djlint_fmt(buf, range, acc)
	local co = assert(coroutine.running())
	vim.schedule(function()
		vim.cmd("silent! write")
	end)
	local handle = vim.system(
		{ "djlint", vim.api.nvim_buf_get_name(buf), "--reformat", "--format-css", "--format-js" },
		{},
		function(result)
			if result.code > 1 then
				coroutine.resume(co, { error = result.stderr })
			else
				coroutine.resume(co, result.stdout)
				vim.schedule(function()
					vim.cmd("silent! edit!")
				end)
			end
		end
	)
	handle:write(nil)
	return coroutine.yield()
end

return {
	"nvimdev/guard.nvim",
	dependencies = { "nvimdev/guard-collection" },
	config = function()
		local ft = require("guard.filetype")

		ft("lua"):fmt("stylua")
		ft("htmldjango"):fmt({ fn = djlint_fmt })
		ft("html"):fmt({ fn = djlint_fmt })
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
		ft("typescript"):fmt("prettier")
		ft("javascript"):fmt("prettier")
		ft("tsx"):fmt("prettier")
		ft("typescriptreact"):fmt("prettier")
		ft("css"):fmt("prettier")
		ft("yaml"):fmt("prettier")
		ft("markdown"):fmt("prettier")

		ft("rust"):fmt("rustfmt")
		ft("json"):fmt("jq")
		ft("dart"):fmt("dart")

		vim.g.guard_config = {
			fmt_on_save = false,
			lsp_as_default_formatter = false,
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
