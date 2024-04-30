local function augroup(name)
	return vim.api.nvim_create_augroup(name, {})
end
-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = augroup("auto_cursorline_show"),
	callback = function(event)
		if vim.bo[event.buf].buftype == "" then
			vim.opt_local.cursorline = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = augroup("auto_cursorline_hide"),
	callback = function(_)
		vim.opt_local.cursorline = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"toggleterm",
		"blame",
		"checkhealth",
		"fugitive",
		"fugitiveblame",
		"help",
		"httpResult",
		"lspinfo",
		"notify",
		"PlenaryTestPopup",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"oil",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		-- stylua: ignore
		vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
	end,
})

local map = vim.keymap.set
vim.api.nvim_create_autocmd("FileType", {

	pattern = "html,htmldjango,jinja",
	callback = function()
		map("v", "<leader>t", [[c{% trans %}<c-r>"{% endtrans %}<esc>]], { desc = "{% trans %}{% endtrans %}" })
		map("n", "<leader>t", [[i{% trans %}{% endtrans %}<esc>F{i]], { desc = "{% trans %}{% endtrans %}" })

		map("v", "<leader>%", [[c{% <c-r>" %}<esc>]], { desc = "jinja func" })
		map("n", "<leader>%", [[i{%  %}<esc>hhi]], { desc = "jinja func" })

		map("v", "<leader>}", [[c{{ <c-r>" }}<esc>]], { desc = "jinja tag" })
		map("n", "<leader>}", [[i{{  }}<esc>hhi]], { desc = "jinja func" })
	end,
})
