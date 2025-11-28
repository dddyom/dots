local augroup = require("core.utils.au").augroup
local au = require("core.utils.au").au

-- Inlay hints: включены вне insert-режима
au({ "LspAttach", "InsertEnter", "InsertLeave" }, "*", function(event)
	local enabled = event.event ~= "InsertEnter"
	vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
end, augroup("lsp_inlay_hints"))


-- LSP-мэппинги на буфер при Attach
au({ "LspAttach" }, "*", function(args)
	local opts = { buffer = args.buf, noremap = true, silent = true }
	local map = vim.keymap.set

	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	map("n", "z[", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)
	map("n", "z]", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)
	map("n", "D", function()
		local _, win = vim.diagnostic.open_float()
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_set_current_win(win)
		end
	end, opts)
end, augroup("lsp_maps"))


local severity = vim.diagnostic.severity

-- Значки для diagnostics по уровням
vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})
