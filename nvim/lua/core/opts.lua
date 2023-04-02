local opt = vim.opt
vim.cmd("syntax on")
opt.backspace = vim.opt.backspace + { "nostop" } -- Don't stop backspace at insert
-- opt.colorcolumn = "79"
opt.clipboard = "unnamedplus" -- Connection to the system clipboard
-- opt.cmdheight = 0 -- hide command line unless needed
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.cursorline = true -- Highlight the text line of the cursor
opt.expandtab = true -- Enable the use of space in tab
opt.fileencoding = "utf-8" -- File content encoding for the buffer
-- opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
opt.history = 100 -- Number of commands to remember in a history table
opt.ignorecase = true -- Case insensitive searching
opt.mouse = "a" -- Enable mouse support
opt.number = true -- Show numberline
opt.pumheight = 10 -- Height of the pop up menu
opt.scrolloff = 20 -- Number of lines to keep above and below the cursor
opt.shiftwidth = 2 -- Number of space inserted for indentation
opt.sidescrolloff = 20 -- Number of columns to keep at the sides of the cursor
opt.signcolumn = "yes" -- Always show the sign column
opt.smartcase = true -- Case sensitivie searching
opt.splitbelow = true -- Splitting a new window below the current one
opt.splitright = true -- Splitting a new window at the right of the current one
opt.swapfile = false -- Disable use of swapfile for the buffer
opt.tabstop = 2 -- Number of space in a tab
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.timeoutlen = 300 -- Length of time to wait for a mapped sequence
opt.undofile = true -- Enable persistent undo
opt.updatetime = 300 -- Length of time to wait before triggering the plugin
opt.wrap = false -- Disable wrapping of lines longer than the width of window
opt.writebackup = false -- Disable making a backup before overwriting a file
opt.showtabline = 2 -- for tabline
opt.awa = true

