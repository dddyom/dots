return {

  -- -- managing lsp servers
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          -- list of servers for mason to install
          ensure_installed = {
            "cssls",
            "tailwindcss",
            -- "sumneko_lua",
            "emmet_ls",
          },
          -- auto-install configured servers (with lspconfig)
          automatic_installation = true, -- not the same as ensure_installed
        })
      end

}

-- mason_null_ls.setup({
--   -- list of formatters & linters for mason to install
--   ensure_installed = {
--     "prettier", -- ts/js formatter
--     "stylua", -- lua formatter
--     "eslint_d", -- ts/js linter
--   },
--   -- auto-install configured formatters & linters (with null-ls)
--   automatic_installation = true,
-- })