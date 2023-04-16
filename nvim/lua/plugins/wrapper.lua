local M = {
  "yuki-uthman/wrapper.nvim"
}

M.config = function ()
  require("wrapper").setup({
    lua = "print({})",
    javascript = "console.log({})",
    python = "print({})"
  })
end

return M
