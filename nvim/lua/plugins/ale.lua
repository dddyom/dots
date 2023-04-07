local M = {
    "dense-analysis/ale",
}

M.config = function ()
      vim.cmd("let g:ale_completion_enabled = 1")
      vim.cmd("let g:ale_disable_lsp = 1")
      vim.cmd("let g:ale_sign_error = '❌'")
      vim.cmd("let g:ale_sign_error = '⚠️'")
end

return M
