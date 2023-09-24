local opt = vim.opt
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.timeoutlen = 300
opt.updatetime = 300
opt.history = 100
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartcase = true
opt.ignorecase = true
opt.wrap = false
opt.syntax = "on"
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 20
opt.sidescrolloff = 20
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.backspace = vim.opt.backspace + { "nostop" }
opt.shortmess = vim.opt.shortmess + "IS"
opt.cmdheight = 0

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.cmd.inoreabbrev("<buffer> true True")
		vim.cmd.inoreabbrev("<buffer> false False")

		vim.cmd.inoreabbrev("<buffer> // #")
		vim.cmd.inoreabbrev("<buffer> -- #")
		vim.cmd.inoreabbrev("<buffer> null None")
		vim.cmd.inoreabbrev("<buffer> none None")
		vim.cmd.inoreabbrev("<buffer> nil None")
	end,
})
