local leader = require("utils.map").leader

return {
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
  {
    "Wansmer/treesj",
    config = function()
      require('treesj').setup({ use_default_keymaps = true })
      leader('j', "<cmd>lua require('treesj').toggle()<cr>", 'toggle args split')
    end,
  },
  {
    "roobert/search-replace.nvim",
    config = function ()
      require("search-replace").setup()
      vim.o.inccommand = "split"
      leader('rr', "<cmd>SearchReplaceSingleBufferCWord<cr>", 'Replace in current buffer (word under cursor)')
      leader('rR', "<cmd>SearchReplaceMultiBufferCWord<cr>", 'Replace in all buffers')
      leader('re', "<cmd>SearchReplaceSingleBufferCExpr<cr>", 'Replace in current buffer (expession under cursor)')
      leader('rE', "<cmd>SearchReplaceMultiBufferCExpr<cr>", 'Replace in current buffer')
    end
  },
  {
      "elentok/format-on-save.nvim",
      config = function() require('format-on-save').setup({ partial_update = true }) end
  },
  {
    "folke/flash.nvim", event = "VeryLazy", opts = {},
    keys = {
      { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  {
    "andrewferrier/debugprint.nvim",
    config = function ()
      local my_filetypes = {}
      my_filetypes.python = {left = 'print("\x1b[6;30;42m" + f"', right = '" + "\033[0m")', mid_var = "{", right_var = '}" + "\x1b[0m")'}
      require('debugprint').setup({filetypes = my_filetypes})
    end
  },
  {
      "sustech-data/wildfire.nvim",
      event = "VeryLazy",
      config = function() require("wildfire").setup() end
  }
}
