local M = {
  "nvim-neo-tree/neo-tree.nvim",
}

M.branch = "v2.x"
M.dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker"
}

M.config = function ()
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

return M
