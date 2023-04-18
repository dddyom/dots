local M = {
  "hrsh7th/nvim-cmp",
}

M.dependencies = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-cmdline',

-- snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "onsails/lspkind.nvim"
}

M.config = function ()
    require("luasnip.loaders/from_vscode").lazy_load()
    local cmp = require "cmp"
    local luasnip = require 'luasnip'
     cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuThumb,Search:None"
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
        -- behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
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
          { name = 'cmp_tabnine' },
        },
      }
end
return M
