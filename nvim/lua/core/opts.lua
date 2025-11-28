local opt = vim.opt

-----------------------------------------------------------------------------
-- UI
-----------------------------------------------------------------------------
opt.termguicolors = true
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.syntax = "on"

-----------------------------------------------------------------------------
-- Буферы, сессии, folds
-----------------------------------------------------------------------------
opt.hidden = true
opt.sessionoptions:remove({ "buffers", "folds" })
opt.viewoptions:remove("folds")

-----------------------------------------------------------------------------
-- Ввод и курсор
-----------------------------------------------------------------------------
opt.mouse = "a"
opt.virtualedit = "block"
opt.backspace:append("nostop")
opt.infercase = true

-----------------------------------------------------------------------------
-- Поиск
-----------------------------------------------------------------------------
opt.smartcase = true
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true

-----------------------------------------------------------------------------
-- Производительность
-----------------------------------------------------------------------------
opt.timeoutlen = 300
opt.updatetime = 300
opt.history = 100

-----------------------------------------------------------------------------
-- Отступы и табы
-----------------------------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.breakindentopt = { shift = 2, min = 20 }

-----------------------------------------------------------------------------
-- Сплиты
-----------------------------------------------------------------------------
opt.splitbelow = true
opt.splitright = true

-----------------------------------------------------------------------------
-- Файлы и история изменений
-----------------------------------------------------------------------------
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.writebackup = false
opt.undofile = true

-----------------------------------------------------------------------------
-- Командная строка и completion
-----------------------------------------------------------------------------
opt.wildmode = "longest:full,full"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cmdheight = 0

-----------------------------------------------------------------------------
-- grep (rg/ag)
-----------------------------------------------------------------------------
if vim.fn.executable("rg") then
	opt.grepprg = "rg --vimgrep --no-heading" .. (opt.smartcase and " --smart-case" or "") .. " --"
elseif vim.fn.executable("ag") then
	opt.grepprg = "ag --vimgrep" .. (opt.smartcase and " --smart-case" or "") .. " --"
end

opt.grepformat = "%f:%l:%c:%m"

-----------------------------------------------------------------------------
-- diff-настройки
-----------------------------------------------------------------------------
opt.diffopt:append({ "iwhite", "indent-heuristic", "algorithm:patience" })

-----------------------------------------------------------------------------
-- Отключение лишних провайдеров
-----------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-----------------------------------------------------------------------------
-- Отключение стандартных git/man-мэпов
-----------------------------------------------------------------------------
vim.g.no_gitrebase_maps = 1
vim.g.no_man_maps = 1

-----------------------------------------------------------------------------
-- Дополнительные filetype-правила
-----------------------------------------------------------------------------
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
		[".*/%.env"] = "sh",
		[".*/%.env%..*"] = "sh",
	},
})

-----------------------------------------------------------------------------
vim.opt.spelloptions:append("camel") -- spell для camelCase
vim.opt.shada = { "'1000", "<50", "s10", "h" }

vim.opt.errorbells = true
vim.opt.visualbell = true

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20
vim.opt.pumheight = 10

vim.opt.conceallevel = 3
vim.opt.inccommand = "nosplit"

vim.opt.path:append("**")

vim.opt.linebreak = true
vim.opt.breakat = "\\ \\t;:,!?"
vim.opt.startofline = false

vim.opt.complete:append("k")
