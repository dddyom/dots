local opts = { silent = true }
local map = vim.keymap.set

return {
    "nvim-lua/plenary.nvim",
    "christoomey/vim-tmux-navigator",
    "szw/vim-maximizer",
    "folke/lsp-colors.nvim",
    {
      'dense-analysis/ale',
      config = function()
        map('n', "<M-CR>", ':ALEImport<CR>', opts)
        map('i', "<M-CR>", '<Esc>:ALEImport<CR>a', opts)
      end
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
        map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
      end

    
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end
    }, 
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup()
      end
    },
    {
      "m4xshen/smartcolumn.nvim",
      config = function()
        require("smartcolumn").setup()
      end
    }, {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup()
      end

    }
}
