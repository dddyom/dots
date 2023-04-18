local M = {
  "andrewferrier/debugprint.nvim",
}
M.dependencies = {
  "nvim-treesitter/nvim-treesitter",
}


M.config = function ()

  local my_filetypes = {}
  my_filetypes.python = {
        left = 'print(f"',
        right = '")',
        mid_var = "{",
        right_var = '}")',
  }

    require('debugprint').setup({
        create_keymaps = false,
        filetypes = my_filetypes
  })
end
return M
