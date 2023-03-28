return {
  "hrsh7th/nvim-cmp",
  dependencies={
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-cmdline',

  -- snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets"
  },
  config = function()

    require("luasnip.loaders/from_vscode").lazy_load()
    local cmp = require "cmp"
    -- local lspkind = require('lspkind')
    local luasnip = require('luasnip')
     cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
        -- window = {
        --   completion = cmp.config.window.bordered(border_opts),
        --   documentation = cmp.config.window.bordered(border_opts),
        -- },
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
        ['<C-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }, 
        formatting = {
          -- format = lspkind.cmp_format({
            -- maxwidth = 50,
            -- ellipsis_char = "...",
          -- }),
        },
      }
  end
}

