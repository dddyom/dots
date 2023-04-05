local M = {

  "nvim-telescope/telescope.nvim",
}

M.branch = "0.1.x"
M.dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'AckslD/nvim-neoclip.lua' },
}
M.config = function ()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            ["<esc>"] = actions.close,
          },
        },
      },
    })
end

return M
