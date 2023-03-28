return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
  },
  config = function()

    require("neo-tree").setup {
     event_handlers = {{
       event = "file_opened",
       handler = function()
                 require("neo-tree").close_all()
                 end
       }
     }
    }


    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  end
}
