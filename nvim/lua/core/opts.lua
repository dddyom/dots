local opt = vim.opt

-- General Options
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.timeoutlen = 300
opt.updatetime = 300
opt.history = 100

-- Text Editing Options
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartcase = true
opt.ignorecase = true
opt.wrap = false

-- Display Options
opt.syntax = "on"
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 20
opt.sidescrolloff = 20
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10

-- File Options
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.writebackup = false
opt.undofile = true

-- Completion Options
opt.completeopt = { "menu", "menuone", "noselect" }

-- Set backspace behavior
opt.backspace = vim.opt.backspace + { "nostop" }

-- Short message settings
opt.shortmess = vim.opt.shortmess + "IS"
