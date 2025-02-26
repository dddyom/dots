local opt = vim.opt

-----------------------------------------------------------------------------
-- UI и Визуальные Настройки
-----------------------------------------------------------------------------
opt.termguicolors = true -- Поддержка 24-битных цветов
opt.number = true -- Отображение номеров строк
opt.cursorline = true -- Подсветка текущей строки
opt.signcolumn = "yes" -- Всегда показывать колонку знаков
opt.syntax = "on" -- Включить синтаксическую подсветку
opt.listchars = { -- Символы, заменяющие скрытые символы
	tab = "  ",
	extends = "⟫",
	precedes = "⟪",
	nbsp = "␣",
	trail = "·",
}
opt.fillchars = { -- Символы для различных UI-элементов
	foldopen = "󰅀",
	foldclose = "󰅂",
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

-----------------------------------------------------------------------------
-- Буферы, вкладки и сессии
-----------------------------------------------------------------------------
opt.hidden = true -- Буферы остаются открытыми, даже если переключиться на другой
opt.sessionoptions:remove({ "buffers", "folds" }) -- Не сохранять буферы и свёртки в сессиях
opt.viewoptions:remove("folds") -- Не запоминать свёртки

-----------------------------------------------------------------------------
-- Ввод и Поведение Курсора
-----------------------------------------------------------------------------
opt.mouse = "a" -- Разрешить работу мышью
opt.virtualedit = "block" -- Разрешить курсору двигаться в пустые области в блок-режиме
opt.backspace:append("nostop") -- Позволяет backspace удалять за границами вставки
opt.infercase = true -- Автоматически определять регистр при автодополнении

-----------------------------------------------------------------------------
-- Настройки поиска
-----------------------------------------------------------------------------
opt.smartcase = true -- Учитывать регистр, если введён хотя бы один символ в верхнем регистре
opt.ignorecase = true -- Игнорировать регистр при поиске
opt.incsearch = true -- Инкрементальный поиск
opt.hlsearch = true -- Подсветка найденных результатов поиска

-----------------------------------------------------------------------------
-- Производительность
-----------------------------------------------------------------------------
opt.timeoutlen = 300 -- Время ожидания для последовательностей команд (мс)
opt.updatetime = 300 -- Время обновления событий (например, автосохранения) (мс)
opt.history = 100 -- Количество команд в истории

-----------------------------------------------------------------------------
-- Работа с вкладками и отступами
-----------------------------------------------------------------------------
opt.expandtab = true -- Преобразовывать табы в пробелы
opt.shiftwidth = 4 -- Размер отступа
opt.tabstop = 4 -- Количество пробелов в табе
opt.softtabstop = 4 -- Отступ для табуляции при редактировании
opt.breakindentopt = { shift = 2, min = 20 } -- Дополнительные опции переноса строк

-----------------------------------------------------------------------------
-- Разделение окон
-----------------------------------------------------------------------------
opt.splitbelow = true -- Окна разделяются снизу
opt.splitright = true -- Окна разделяются справа

-----------------------------------------------------------------------------
-- Файловые форматы и кодировки
-----------------------------------------------------------------------------
opt.fileencoding = "utf-8" -- Кодировка файлов
opt.swapfile = false -- Отключение swap-файлов
opt.writebackup = false -- Отключение резервных копий
opt.undofile = true -- Включение возможности отмены после перезапуска

-----------------------------------------------------------------------------
-- Улучшение работы с командной строкой
-----------------------------------------------------------------------------
opt.wildmode = "longest:full,full" -- Улучшенная автодополняемая командная строка
opt.completeopt = { "menu", "menuone", "noselect" } -- Улучшенное автодополнение
opt.cmdheight = 0 -- Высота командной строки

-----------------------------------------------------------------------------
-- Настройки работы с grep (если `rg` или `ag` установлен)
-----------------------------------------------------------------------------
if vim.fn.executable("rg") then
	opt.grepprg = "rg --vimgrep --no-heading" .. (opt.smartcase and " --smart-case" or "") .. " --"
elseif vim.fn.executable("ag") then
	opt.grepprg = "ag --vimgrep" .. (opt.smartcase and " --smart-case" or "") .. " --"
end

opt.grepformat = "%f:%l:%c:%m"

-----------------------------------------------------------------------------
-- Оптимизация `diff`
-----------------------------------------------------------------------------
opt.diffopt:append({ "iwhite", "indent-heuristic", "algorithm:patience" }) -- Улучшенный алгоритм сравнения в diff

-----------------------------------------------------------------------------
-- Отключение ненужных провайдеров (ускоряет Neovim)
-----------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-----------------------------------------------------------------------------
-- Запрет стандартных команд для Git и man
-----------------------------------------------------------------------------
vim.g.no_gitrebase_maps = 1 -- Отключение встроенных карт для gitrebase
vim.g.no_man_maps = 1 -- Отключение встроенных карт для man

-----------------------------------------------------------------------------
-- Определение типов файлов
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
	},
})


-----------------------------------------------------------------------------
-- Дополнительные настройки
vim.opt.spelloptions:append("camel") -- Проверка орфографии в camelCase
vim.opt.shada = { "'1000", "<50", "s10", "h" } -- Настройки истории и кеширования

vim.opt.errorbells = true -- Звуковой сигнал при ошибке
vim.opt.visualbell = true -- Визуальный сигнал вместо звукового

vim.opt.clipboard = "unnamedplus" -- Использовать системный буфер обмена

vim.opt.wrap = false -- Отключение автоматического переноса строк
vim.opt.scrolloff = 20 -- Отступ строк сверху и снизу при скроллинге
vim.opt.sidescrolloff = 20 -- Отступ по горизонтали при скроллинге
vim.opt.pumheight = 10 -- Максимальное количество строк в popup-меню

vim.opt.shortmess:append("I") -- Отключение `intro screen`
vim.opt.conceallevel = 3 -- Скрывать некоторые символы (`markdown`, `json`, `tex`)
vim.opt.inccommand = "nosplit" -- Интерактивный поиск и замена без разделения окна

vim.opt.path:append("**") -- Поиск файлов рекурсивно

vim.opt.linebreak = true -- Перенос длинных строк по `breakat`
vim.opt.breakat = "\\ \\t;:,!?" -- Разрешённые символы для разрыва строк
vim.opt.startofline = false -- Курсор остаётся в колонке при перемещениях

vim.opt.complete:append("k") -- Автодополнение с учётом ключевых слов
