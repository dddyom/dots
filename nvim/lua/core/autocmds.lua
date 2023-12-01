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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
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



local opt = vim.opt
local inoreabbrev = vim.cmd.inoreabbrev
vim.api.nvim_create_autocmd("FileType", {

	pattern = "python",
	callback = function()
		inoreabbrev("<buffer> true True")
		inoreabbrev("<buffer> false False")

		opt.shiftwidth = 4
		opt.tabstop = 4
		inoreabbrev("<buffer> // #")
		inoreabbrev("<buffer> -- #")
		inoreabbrev("<buffer> null None")
		inoreabbrev("<buffer> none None")
		inoreabbrev("<buffer> nil None")
	end,
})
