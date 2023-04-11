local M = {
  'VonHeikemen/lsp-zero.nvim',
}

M.branch = 'v2.x'


M.dependencies = {

  "SmiteshP/nvim-navic",
  'nvim-lua/lsp-status.nvim',
  'neovim/nvim-lspconfig',
  {
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
  },
  {'williamboman/mason-lspconfig.nvim'},

  -- Autocompletion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'saadparwaiz1/cmp_luasnip'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-nvim-lua'},

  -- Snippets
  {'L3MON4D3/LuaSnip'},
  {'rafamadriz/friendly-snippets'},
}

M.config = function ()

    local lsp = require('lsp-zero').preset({})
    local navic = require("nvim-navic")
    lsp.on_attach(function(client, bufnr)
      require('lsp-status').on_attach(client)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
      lsp.default_keymaps({buffer = bufnr})
    end)
    lsp.set_sign_icons({
      error = '',
      warn = '',
      hint = '',
      info = 'פֿ'
    })
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    lsp.setup()
    vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
end

return M
