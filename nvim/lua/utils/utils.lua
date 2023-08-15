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


local read_env_file = function (filename)
    local env_vars = {}
    local file = io.open(filename, "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("([^=]+)=(.+)")
            if key and value then
                env_vars[key] = value
            end
        end
        file:close()
    end
    return env_vars
end

local drop_quotes= function(str)
    return str:gsub("['\"]", "")
end

M.get_dbs = function()
    local dbs = {}
    local centers = os.getenv('CENTERS')
    local conn_dir = os.getenv('CONNECTIONS_ROOT_DIR')
    if centers ~= nil and conn_dir ~= nil then
      for center in centers:gmatch("[^,]+") do
        local env_file = conn_dir .. '/' .. center .. '/.env'

        local cur_conn = read_env_file(env_file)

        table.insert(dbs, {
          name = center,
          url = string.format(
              "jdbc:sqlserver://%s:%s@%s:%s;database=%s",
              drop_quotes(cur_conn['DB_USER']),
              drop_quotes(cur_conn['DB_PASSWORD']),
              drop_quotes(cur_conn['DB_HOST']),
              drop_quotes(cur_conn['DB_PORT']),
              drop_quotes(cur_conn['DB_NAME'])
          )
        })
      end
    end
    return dbs
  end

M.get_project_name = function(path)
    while path and path ~= '' do
        local git_dir = path .. '/.git'
        local is_directory = vim.fn.isdirectory(git_dir)
        if is_directory == 1 then
            return vim.fn.fnamemodify(path, ':t')
        end
        path = path:match('(.*)/[^/]*$') -- Move up one directory level
    end
    return path
end

return M
