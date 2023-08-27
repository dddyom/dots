return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    "folke/lsp-colors.nvim",
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    "SmiteshP/nvim-navic",
    'nvim-lua/lsp-status.nvim',
    { 'dnlhc/glance.nvim', config = true },
    { "folke/neodev.nvim", opts = {} },

    {
      'williamboman/mason.nvim',
      build = function() pcall(vim.cmd, 'MasonUpdate') end,
    },
  },
  config = function ()
    require("neodev").setup()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
      require('lsp-status').on_attach(client)
      if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end
      lsp.default_keymaps({buffer = bufnr})
    end)
    lsp.set_sign_icons({ error = '', warn = '', hint = '', info = 'פֿ' })

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    lsp.setup()
    require('utils.utils').set_cmp_icons()
  end
}
