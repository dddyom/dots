return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- local custom_colors = {
    --   blue = "#65D1FF",
    --   green = "#3EFFDC",
    --   violet = "#FF61EF",
    --   yellow = "#FFDA7B",
    --   black = "#000000",
    -- }

    -- lualine_nightfly.normal.a.bg = custom_colors.blue
    -- lualine_nightfly.insert.a.bg = custom_colors.green
    -- lualine_nightfly.visual.a.bg = custom_colors.violet
    -- lualine_nightfly.command = {
    --   a = {
    --     gui = "bold",
    --     bg = custom_colors.yellow,
    --     fg = custom_colors.black,
    --   }
    -- }

    require("lualine").setup {
      options = {
        -- theme = 'catpuccin',
        component_separators = "|",
      	-- section_separators = { left = "", right = "" },
      },
      sections = {
        -- lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", { "diff", colored = false } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        -- lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            -- separator = { left = "", right = "" },
            right_padding = 2,
            symbols = { alternate_file = "" },
          },
        },
      },
    }

  end
}


