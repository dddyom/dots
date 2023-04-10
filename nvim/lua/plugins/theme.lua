local M = {
  -- "catppuccin/nvim"
  "navarasu/onedark.nvim"
}

M.config = function ()
    require('onedark').setup {
        style = 'deep', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
      lualine = {
          transparent = true, -- lualine center bar transparency
      },
    }
    require('onedark').load()
    vim.cmd.colorscheme "onedark"
end

return M
