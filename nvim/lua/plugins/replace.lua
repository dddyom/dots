local M = {
  "roobert/search-replace.nvim"
}
M.config = function ()
    require("search-replace").setup({
      -- default_replace_single_buffer_options = "gcI",
      -- default_replace_multi_buffer_options = "egcI",
    })
  vim.o.inccommand = "split"
end

return M
