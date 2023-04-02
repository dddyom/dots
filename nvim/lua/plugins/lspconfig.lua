return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
		  {'neovim/nvim-lspconfig'},
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
  },
  config = function()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end
}
