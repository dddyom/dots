local M = {
  "numToStr/Comment.nvim",
}

M.config = function ()
    vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })
    vim.keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { silent = true })
end

return M
