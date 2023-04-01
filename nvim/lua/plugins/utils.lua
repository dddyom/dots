local opts = { silent = true }
local map = vim.keymap.set

return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "szw/vim-maximizer",
  "folke/lsp-colors.nvim",
  "tpope/vim-fugitive",
  'jghauser/mkdir.nvim', {
  "numToStr/Comment.nvim",
    config = function()
      map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
      map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    end
  }, {
  "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end
  }, {
  "lukas-reineke/indent-blankline.nvim",
    config = function() require("indent_blankline").setup() end
  }, {
  "m4xshen/smartcolumn.nvim",
    config = function() require("smartcolumn").setup() end
  }, {
  "simrat39/symbols-outline.nvim",
    config = function() require("symbols-outline").setup() end
  }, {
  "lewis6991/gitsigns.nvim",
    config = function() require('gitsigns').setup() end
  }, {
  'smzm/hydrovim',
    dependencies = { 'MunifTanjim/nui.nvim' }
  }, {
  "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end
  }, {
    's1n7ax/nvim-search-and-replace',
    config = function() require'nvim-search-and-replace'.setup() end,
  }, {
  "tversteeg/registers.nvim",
    name = "registers",
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    cmd = "Registers",
  },
}

