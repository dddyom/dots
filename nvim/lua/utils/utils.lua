local M = {}

M.set_cmp_icons = function ()
     require "cmp".setup {
      formatting = {
        format = function (entry, vim_item)
          local icons = require("utils.icons")
          vim_item.kind = icons[vim_item.kind]
          vim_item.menu = icons[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
                          local detail = (entry.completion_item.labelDetails or {}).detail
                  vim_item.kind = ""
                  if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                  end

                  if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                  end
                end
          return vim_item
        end
      }
    }
end

return M
