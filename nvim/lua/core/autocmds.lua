local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

local function set_cursorline(show)
	vim.opt_local.cursorline = show
end

-- Auto Cursorline Show/Hide
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = augroup("auto_cursorline_show"),
	callback = function(event)
		if vim.bo[event.buf].buftype == "" then
			set_cursorline(true)
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = augroup("auto_cursorline_hide"),
	callback = function()
		set_cursorline(false)
	end,
})

-- LSP Inlay Hints Toggle
vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
	group = augroup("lsp_inlay_hints"),
	callback = function(event)
		local enabled = event.event ~= "InsertEnter"
		vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
	end,
})

-- Auto Disable Highlight Search
vim.api.nvim_create_autocmd("CursorMoved", {
	group = augroup("auto_hlsearch"),
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.searchcount({ exact = true }).total == 0 then
			vim.schedule(function()
				vim.cmd("nohlsearch")
			end)
		end
	end,
})

-- Close Certain Filetypes with 'q'
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
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- HTML, Django, Jinja Keymaps
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("html_django_jinja_keymaps"),
	pattern = "html,htmldjango,jinja",
	callback = function()
		local map = vim.keymap.set
		map("v", "<leader>t", [[c{% trans %}<c-r>"{% endtrans %}<esc>]], { desc = "{% trans %}{% endtrans %}" })
		map("n", "<leader>t", [[i{% trans %}{% endtrans %}<esc>F{i]], { desc = "{% trans %}{% endtrans %}" })
		map("v", "<leader>%", [[c{% <c-r>" %}<esc>]], { desc = "jinja func" })
		map("n", "<leader>%", [[i{%  %}<esc>hhi]], { desc = "jinja func" })
		map("v", "<leader>}", [[c{{ <c-r>" }}<esc>]], { desc = "jinja tag" })
		map("n", "<leader>}", [[i{{  }}<esc>hhi]], { desc = "jinja func" })
	end,
})

-- Set filetype for Django HTML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("set_filetype_htmldjango"),
	pattern = { "*.html" },
	command = "set filetype=htmldjango",
})

-- Auto Resize Split Windows
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("auto_resize_windows"),
	desc = "Auto resize split windows",
	command = "tabdo wincmd =",
})

-- Remove Trailing Whitespace on Save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("remove_trailing_whitespace"),
	desc = "Remove trailing whitespace on save",
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Prevent Auto Commenting New Line
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	group = augroup("no_auto_comment"),
	desc = "Don't auto comment new line",
	pattern = "*",
	command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Jump to Last Position When Reopening a File
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("jump_to_last_position"),
	desc = "Jump to the last position when reopening a file",
	pattern = "*",
	command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_on_yank"),
	desc = "Highlight on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "Search",
			timeout = 300,
			on_visual = true,
		})
	end,
})
