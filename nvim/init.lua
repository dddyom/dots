-- LAZY NVIM INSTALLATION IF NOT EXISTS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- BASE OPTIONS
vim.opt.rtp:prepend(lazypath)
require("core.opts")
require("core.maps")
require("core.autocmds")

-- LOAD PLUGINS
require("lazy").setup("plugins")
require("core.intro")
