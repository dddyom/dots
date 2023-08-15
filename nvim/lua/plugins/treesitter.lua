return {
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
          'vim', 'markdown', 'yaml'
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
