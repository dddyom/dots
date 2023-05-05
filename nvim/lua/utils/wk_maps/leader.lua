local M = {}

M.leader_opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.leader_maps = {
  ['t'] = {"<cmd>ToggleTerm<CR>", 'terminal'},
  ['g'] = {"<cmd>lua _lazygit_toggle()<CR>", 'git'},
  ['m'] = {'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'marks menu'},
  ["c"] = { "<cmd>ChatGPT<CR>", "chatGPT" },
  ["w"] = { "<cmd>update!<CR>", "save" },
  ["q"] = { "<cmd>q!<CR>", "quit" },
  ["e"] = { "<cmd>NeoTreeFocusToggle<cr>", "file explorer" },
  [']'] = { "<cmd>CellularAutomaton make_it_rain<CR>", "rain" },
  ['v'] = {"<cmd>VenvSelect<cr>", 'selecte venv'},
  ['s'] = {"<cmd>SymbolsOutline<CR>", 'code structure'},
  ['i'] = {"<cmd>ALEImport<CR>", 'python import' },
  ['a'] = {"<cmd>lua require('trevj').format_at_cursor()<cr>", "format args"},
  [','] = {"<cmd>SnipClose<cr>", 'SnipClose'},
  ['.'] = {"<cmd>DeleteDebugPrints<cr>", 'delete debug prints'},
  f = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files hidden=true<cr>", "find file" },
    w = {"<cmd>Telescope live_grep<cr>", 'find by word'},
    s = {"<cmd>Telescope grep_string<cr>", 'find by word under cursor'},
    b = {"<cmd>Telescope buffers<cr>", 'find in open buffers'},
    h = {"<cmd>Telescope help_tags<cr>", 'help tags'},
    c = {"<cmd>Telescope neoclip<cr>", 'clipboard'}
  },
  b = {
    name = 'buffers split',
    v = { "<c-w>v", "split window vertically" },
    h = { "<c-w>s", "split window horisontally" },
    x = { "<cmd>close<cr>", "close current split window" },
    -- n = { "<cmd>tabnew<cr>", "open new tab" }
  },
  x = {
    name = 'LSP',
    d = {"<CMD>Glance definitions<CR>", 'definitions'},
    r = {"<CMD>Glance references<CR>", 'references'},
  },
  r = {
    name = 'replace',
    r = {"<cmd>SearchReplaceSingleBufferCWord<cr>", 'replace word under cursor (single buffer)'},
    R = {"<cmd>SearchReplaceMultiBufferCWord<cr>", 'replace word under cursor (multiple buffers)'},
    e = {"<cmd>SearchReplaceSingleBufferCWORD<cr>", 'replace expression under cursor (single buffer)'},
    E = {"<cmd>SearchReplaceMultiBufferCWORD<cr>", 'replace expression under cursor (multiple buffer)'},
  },
}
return M
