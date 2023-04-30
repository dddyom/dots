local M = {
  "nvim-treesitter/nvim-treesitter",
}

M.dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'jeetsukumaran/vim-pythonsense'
}
M.build=':TSUpdate'
M.event="BufRead"
M.config = function()
		require("nvim-treesitter.configs").setup {
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
      indent = { enable = false },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
     },
    }
end

return M
