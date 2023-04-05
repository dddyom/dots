local M = {
    "dense-analysis/ale",
}

M.config = function ()
      vim.cmd("let g:ale_completion_enabled = 1")
end

return M
