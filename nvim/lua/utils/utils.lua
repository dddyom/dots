local M = {}

M.set_cmp_icons = function ()
     require "cmp".setup {
      formatting = {
        format = function (entry, vim_item)
          local icons = require("utils.icons")
          vim_item.kind = icons[vim_item.kind]
          vim_item.menu = icons[entry.source.name]
          return vim_item
        end
      }
    }
end

return M
