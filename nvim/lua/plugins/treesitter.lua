local M = {
  "nvim-treesitter/nvim-treesitter",
}

M.dependencies = {
    'jeetsukumaran/vim-pythonsense'
}
M.build=':TSUpdate'
M.event="BufRead"
M.config = function()
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
      indent = { enable = false },
    }
end

return M
