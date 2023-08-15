return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    'cljoly/telescope-repo.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function ()
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      telescope.setup({
        defaults = {
          layout_strategy = 'vertical',
          layout_config = { preview_cutoff = 0, preview_height = 0.6, prompt_position = "top" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<esc>"] = actions.close,
              ["<c-q>"] = actions.close,
            },
          },
        },
       extensions = { repo = { list = { search_dirs = { "~/code", "~/WorkGit" } } } },
      })

      telescope.load_extension'repo'

      local leader = require("utils.map").leader
      leader('ff',  "<cmd>Telescope find_files hidden=true<cr>", "find file")
      leader('fw', "<cmd>Telescope live_grep<cr>", 'find by word')
      leader('fs', "<cmd>Telescope grep_string<cr>", 'find by word under cursor')
      leader('fb', "<cmd>Telescope buffers<cr>", 'find in open buffers')
      leader('fh', "<cmd>Telescope help_tags<cr>", 'help tags')
      leader('fc', "<cmd>Telescope neoclip<cr>", 'clipboard')
  end
}
