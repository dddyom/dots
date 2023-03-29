return {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      local conf = {
        window = {
          border = "single", -- none, single, double, shadow
          position = "bottom", -- bottom, top
        },
      }
      local opts = {
          mode = "n",
          prefix = "<leader>",
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = false,
        }

      local mappings = {
        ["/"] = {"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", 'comment'},

        ["g"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
        ["w"] = { "<cmd>update!<CR>", "Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" }, 
        ["e"] = { ":NeoTreeFocusToggle<cr>", "File explorer" }, 

        f = {
          name = "Telescope",
          f = { "<cmd>Telescope find_files<cr>", "Find file" },
          w = {"<cmd>Telescope live_grep<cr>", 'Find by word'},
          c = {"<cmd>Telescope grep_string<cr>", 'Find by word under cursor'},
          b = {"<cmd>Telescope buffers<cr>", 'Find in open buffers'},
          h = {"<cmd>Telescope help_tags<cr>", 'Help tags'},
        },
        w = {
          name = 'Windows',
          c = { ":bd<cr>", "close current buffer" },
          v = { "<c-w>v", "split window vertically" },
          h = { "<c-w>s", "split window horisontally" },
          x = { ":close<cr>", "close current split window" }
        },
        t = {
          name = 'Tabs',
          n = { ":tabnew<cr>", "open new tab" }

        },
        h = {
          name = 'Harpoon',
          m  = {'<cmd>lua require("harpoon.mark").add_file()<CR>', 'Add mark'},
          e = {'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Marks menu'},
          -- 1 = {'<cmd>lua require("harpoon.ui").nav_file(1)<CR>', 'Move to mark 1'},
          -- 2 = {'<cmd>lua require("harpoon.ui").nav_file(2)<CR>', 'Move to mark 2'},
          -- 3 = {'<cmd>lua require("harpoon.ui").nav_file(3)<CR>', 'Move to mark 3'},
          -- 4 = {'<cmd>lua require("harpoon.ui").nav_file(4)<CR>', 'Move to mark 4'},
          h = {'<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Prev mark"},
          l = {'<cmd>lua require("harpoon.ui").nav_next()<CR>', "Next mark"},

        },
        -- g = {
        --   name = "Git",
        --   s = { "<cmd>Neogit<CR>", "Status" },
        -- },
        l = {
          name = 'Lspsaga',
          o = {"<cmd>LSoutlineToggle<CR>", 'Outline'},
          c = {"<cmd>Lspsaga code_action<CR>", 'Code actions'},
          r = {"<cmd>Lspsaga rename<CR>", "Rename"},
          d = {"<cmd>Lspsaga show_line_diagnostics<CR>", 'Diagnostic'}
        },
        v = {
          name = 'venv',
          s = {"<cmd>:VenvSelect<cr>", 'selecte venv'},
        }
      }
      wk.setup(conf)
      wk.register(mappings, opts)
    end,
}
