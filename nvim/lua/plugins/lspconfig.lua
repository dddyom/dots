return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "glepnir/lspsaga.nvim", branch = "main" },
    "onsails/lspkind.nvim",
    'ray-x/lsp_signature.nvim',
  },
  config = function()
    local opts = { silent = true, noremap = true, buffer = bufnr  }
    local map = vim.keymap.set
    local util = require 'lspconfig/util'
    local path = util.path
    local lspconfig = require "lspconfig"
    local cmp_nvim_lsp = require "cmp_nvim_lsp"
    local custom_attach = function(client)
          require'lsp_signature'.on_attach({
              bind = true,
              handler_opts = {
                  border = "single"
              },
          });
        end
    require"lspsaga".setup({
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
      },
      ui = {
        colors = {
          normal_bg = "#022746",
        },
      },
    })

    map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

    local signs = { error = " ", warn = " ", hint = "ﴞ ", info = " " }
    for type, icon in pairs(signs) do
      local hl = "diagnosticsign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local servers = {
      'pyright',
      -- 'bashls',
      'emmet_ls'
    }
    for _, s in ipairs(servers) do
        lspconfig[s].setup{
          on_attach=custom_attach,
          capabilities =cmp_nvim_lsp.default_capabilities(),
      }
    end


  end
}
