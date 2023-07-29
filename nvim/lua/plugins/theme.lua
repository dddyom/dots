local M = {
  -- "catppuccin/nvim"
  "Shatur/neovim-ayu"
}

M.config = function ()
  require('ayu').setup({
      mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
      overrides = {
          Normal = { bg = "None" },
          ColorColumn = { bg = "None" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorLine = { bg = "None" },
          CursorColumn = { bg = "None" },
          WhichKeyFloat = { bg = "None" },
          VertSplit = { bg = "None" },
      },
  })
  vim.cmd("colorscheme ayu")

end


-- M.config = function ()
--   -- "navarasu/onedark.nvim"
--     require('onedark').setup {
--         style = 'darker', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
--       lualine = {
--           transparent = true, -- lualine center bar transparency
--       },
--     }
--     require('onedark').load()
--     vim.cmd.colorscheme "onedark"
-- end

return M
