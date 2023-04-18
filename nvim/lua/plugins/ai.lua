local tabnine = {
  'codota/tabnine-nvim'
}
tabnine.build = "./dl_binaries.sh"

tabnine.config = function ()
  require('tabnine').setup({
    disable_auto_comment=true,
    accept_keymap="<Tab>",
    dismiss_keymap = "<C-]>",
    debounce_ms = 800,
    suggestion_color = {gui = "#808080", cterm = 244},
    exclude_filetypes = {"TelescopePrompt"}
  })
end

local cmp_tabnine = {
  'tzachar/cmp-tabnine'
}

cmp_tabnine.build = './install.sh'

cmp_tabnine.config = function ()
  local tabnine = require('cmp_tabnine.config')
  tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = {
      -- default is not to ignore
      -- uncomment to ignore in lua:
      -- lua = true
    },
    show_prediction_strength = false
  })
end

local M = {}
table.insert(M, tabnine)
table.insert(M, cmp_tabnine)

return M
