local M = {
  "eandrju/cellular-automaton.nvim",
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "szw/vim-maximizer",
  "folke/lsp-colors.nvim",
  "tpope/vim-fugitive",
  "jghauser/mkdir.nvim",
  "RRethy/vim-illuminate",
  'David-Kunz/markid',
  'christoomey/vim-tmux-navigator'
}


local utils_with_config = {
  "windwp/nvim-autopairs",
  "simrat39/symbols-outline.nvim",
  "lewis6991/gitsigns.nvim",
  'simrat39/symbols-outline.nvim',
  'dnlhc/glance.nvim',
  "ThePrimeagen/harpoon",
}

for _, plug in pairs(utils_with_config) do
  table.insert(M, {
    plug, config=true
  })
end

local plugins = {}


plugins.colorizer = {
    "norcalli/nvim-colorizer.lua",
    config = function () require("colorizer").setup() end
}


plugins.surround = {
  "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
}

plugins.hlargs = {
  'm-demare/hlargs.nvim',
  dependencies={ 'nvim-treesitter/nvim-treesitter' },
  config = function () require('hlargs').setup() end

}

plugins.rainbow = {
  "mrjones2014/nvim-ts-rainbow",
  config=function ()
    require('nvim-treesitter.configs').setup({
      highlight = {},
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
    })
  end
}

plugins.trevj = {
  "AckslD/nvim-trevJ.lua",
  config = function ()
      require('trevj').setup({
        containers = {
          lua = {
            table_constructor = {final_separator = ',', final_end_line = true},
            arguments = {final_separator = false, final_end_line = true},
            parameters = {final_separator = false, final_end_line = true},
          },
        },
      })
  end
}

plugins.icon_picker = {
  "ziontee113/icon-picker.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
  },

  config = function()
    require("icon-picker").setup({
      disable_legacy_commands = true
    })
  end,
}

plugins.sniprun = {
  'michaelb/sniprun',
  build = "bash install.sh"

}

plugins.codeium = {
  "Exafunction/codeium.vim",
  config = function ()
    vim.keymap.set('i', '<C-a>', function () return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end

}

plugins.comments = {
  "numToStr/Comment.nvim",
  config = function ()
    vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })
    vim.keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { silent = true })
  end
}

plugins.leap = {
  "ggandor/leap.nvim",
  config = function ()
    vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
    vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')
  end
}

plugins.replace = {
  "roobert/search-replace.nvim",
  config = function ()
    require("search-replace").setup({
      -- default_replace_single_buffer_options = "gcI",
      -- default_replace_multi_buffer_options = "egcI",
    })
  vim.o.inccommand = "split"
  end
}

plugins.venv_selector = {
	"linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  config = true,
  opts = { parents=4 },
}

plugins.git_conflict = {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true
}

for _, plug in pairs(plugins) do
  table.insert(M, plug)
end



return M
