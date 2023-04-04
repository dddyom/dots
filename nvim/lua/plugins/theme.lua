local M = {
  "catppuccin/nvim"
}

M.config = function ()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    })
    vim.cmd.colorscheme "catppuccin"
end

return M
