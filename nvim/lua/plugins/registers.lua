local M = {
  "tversteeg/registers.nvim",
}

M.name = "registers"
M.keys = {
  { "\"",    mode = { "n", "v" } },
  { "<C-R>", mode = "i" }
}

M.cmd = "Registers"

return M
