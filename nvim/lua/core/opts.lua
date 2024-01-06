local opt = vim.opt

opt.spelloptions:append("camel")
opt.viewoptions:remove("folds")
opt.sessionoptions:remove({ "buffers", "folds" })
opt.shada = { "'1000", "<50", "s10", "h" }
opt.errorbells = true -- Trigger bell on error
opt.visualbell = true -- Use visual bell instead of beeping
opt.hidden = true -- Hide buffers when abandoned instead of unload
opt.virtualedit = "block" -- Position cursor anywhere in visual block
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.timeoutlen = 300
opt.updatetime = 300
opt.history = 100
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 4
opt.smartcase = true
opt.ignorecase = true
opt.infercase = true -- Adjust case in insert completion mode
opt.incsearch = true
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
opt.backspace = opt.backspace + { "nostop" }
opt.shortmess = opt.shortmess + "IS"
opt.cmdheight = 0
opt.conceallevel = 3
opt.inccommand = "nosplit"
opt.grepformat = "%f:%l:%c:%m"
opt.path:append("**") -- Find recursively

opt.linebreak = true -- Break long lines at 'breakat'
opt.breakat = "\\ \\	;:,!?" -- Long lines break chars
opt.startofline = false -- Cursor in same column for few commands
opt.splitbelow = true -- Splits open bottom right
opt.splitright = true
opt.breakindentopt = { shift = 2, min = 20 }
opt.complete:append("k")
opt.complete:remove("u")
opt.complete:remove("t")

if vim.fn.executable("rg") then
	opt.grepprg = "rg --vimgrep --no-heading" .. (opt.smartcase and " --smart-case" or "") .. " --"
elseif vim.fn.executable("ag") then
	opt.grepprg = "ag --vimgrep" .. (opt.smartcase and " --smart-case" or "") .. " --"
end

opt.diffopt:append({ "iwhite", "indent-heuristic", "algorithm:patience" })

opt.wildmode = "longest:full,full" -- Command-line completion mode

opt.listchars = {
	tab = "  ",
	extends = "⟫",
	precedes = "⟪",
	nbsp = "␣",
	trail = "·",
}
opt.fillchars = {
	foldopen = "󰅀", -- 󰅀 
	foldclose = "󰅂", -- 󰅂 
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
-- Misc
-- ===

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.no_gitrebase_maps = 1 -- See share/nvim/runtime/ftplugin/gitrebase.vim
vim.g.no_man_maps = 1 -- See share/nvim/runtime/ftplugin/man.vim

-- Filetype detection
-- ===

---@diagnostic disable-next-line: missing-fields
vim.filetype.add({
	filename = {
		Brewfile = "ruby",
		justfile = "just",
		Justfile = "just",
		Tmuxfile = "tmux",
		["yarn.lock"] = "yaml",
		[".buckconfig"] = "toml",
		[".flowconfig"] = "ini",
		[".jsbeautifyrc"] = "json",
		[".jscsrc"] = "json",
		[".watchmanconfig"] = "json",
		["dev-requirements.txt"] = "requirements",
	},
	pattern = {
		[".*%.js%.map"] = "json",
		[".*%.postman_collection"] = "json",
		["Jenkinsfile.*"] = "groovy",
		["%.kube/config"] = "yaml",
		["%.config/git/users/.*"] = "gitconfig",
		["requirements-.*%.txt"] = "requirements",
		[".*/templates/.*%.ya?ml"] = "helm",
		[".*/templates/.*%.tpl"] = "helm",
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
		[".*/inventory/.*%.ini"] = "ansible_hosts",
	},
})
