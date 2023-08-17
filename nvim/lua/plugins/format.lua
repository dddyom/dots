local leader = require("utils.map").leader

return {
  {
    "Wansmer/treesj",
    config = function()
      require('treesj').setup({ use_default_keymaps = true })
      leader('j', "<cmd>lua require('treesj').toggle()<cr>", 'toggle args split')
    end,
  },

  { "kylechui/nvim-surround", version = "*", event = "VeryLazy",  config = true },

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
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'jeetsukumaran/vim-pythonsense'
    },
    build=':TSUpdate',
    event="BufRead",
    config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = {
            "rust", 'python', 'lua',
            "http", "json", 'jq',
            'html', 'htmldjango',
            'javascript', 'typescript', 'css',
            'vim', 'markdown', 'yaml', 'sql'
          },

          markid = { enable = true },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
          rainbow = {
            enable = true,
            disable = { "html" },
            extended_mode = false,
            max_file_lines = nil,
          },
          autotag = { enable = true },
          incremental_selection = { enable = true },
          indent = { enable = true },
        }
    end
  }
}
