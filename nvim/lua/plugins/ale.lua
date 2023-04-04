local M = {
    "dense-analysis/ale",
}

M.config = function ()
      vim.cmd("let g:ale_completion_enabled = 1")
      vim.keymap.set('n', '<C-CR>', ":ALEImport<cr>", { silent = true })
end

return M
