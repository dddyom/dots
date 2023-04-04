local M = {
	"linux-cultist/venv-selector.nvim",
}

M.dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" }
M.config = true
M.opts = {
    parents=4
}

return M

