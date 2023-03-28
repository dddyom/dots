return {
  "catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
