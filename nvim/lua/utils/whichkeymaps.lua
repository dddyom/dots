local M = {}

M.leader_opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.normal_maps = {

  ['H'] = {'<cmd>lua require("harpoon.ui").nav_prev()<CR>', "prev mark"},
  ['L'] = {'<cmd>lua require("harpoon.ui").nav_next()<CR>', "next mark"},
  ['M'] = {'<cmd>lua require("harpoon.mark").add_file()<CR>', 'add mark'},
}

M.surround_opts = {
  mode = "v",
  prefix = ",",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
M.surround_maps = {
  ["tn"] = {[[c{% trans %}<c-r>"{% endtrans %}<esc>]], "{% trans %}{% endtrans %}"},
  ["cl"] = {[[cconsole.log(<c-r>")<esc>]], "console.log()"},
  ['pp'] = {[[cprint(<c-r>")<esc>]], "print()"},
  ['pc'] = {[[cprint(f"\033[93m{<c-r>"}\033[0m")<esc>]], "color print"},
  ['%'] = {[[c{% <c-r>" %}<esc>]], "jinja func"},
  ['{'] = {[[c{{ <c-r>" }}<esc>]], "jinja tag"}
}

M.leader_maps = {
  ['m'] = {'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'marks menu'},
  ["c"] = { "<cmd>ChatGPT<CR>", "chatGPT" },
  ["w"] = { "<cmd>update!<CR>", "save" },
  ["q"] = { "<cmd>q!<CR>", "quit" },
  ["e"] = { ":NeoTreeFocusToggle<cr>", "file explorer" },
  [']'] = { "<cmd>CellularAutomaton make_it_rain<CR>", "rain" },
  ['v'] = {"<cmd>:VenvSelect<cr>", 'selecte venv'},
  ['a'] = {"<cmd>AerialToggle!<CR>", 'code objects'},
  ['s'] = {"<cmd>:SymbolsOutline<CR>", 'code structure'},
  ['i'] = {":ALEImport<CR>", 'python import' },
  f = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "find file" },
    w = {"<cmd>Telescope live_grep<cr>", 'find by word'},
    s = {"<cmd>Telescope grep_string<cr>", 'find by word under cursor'},
    b = {"<cmd>Telescope buffers<cr>", 'find in open buffers'},
    h = {"<cmd>Telescope help_tags<cr>", 'help tags'},
    c = {"<cmd>Telescope neoclip<cr>", 'clipboard'}
  },
  b = {
    name = 'Buffers',
    c = { ":bd<cr>", "close current buffer" },
    v = { "<c-w>v", "split window vertically" },
    h = { "<c-w>s", "split window horisontally" },
    x = { ":close<cr>", "close current split window" },
    n = { ":tabnew<cr>", "open new tab" }
  },
  x = {
    name = 'LSP',
    d = {"<CMD>Glance definitions<CR>", 'definitions'},
    r = {"<CMD>Glance references<CR>", 'references'},
  },
  r = {
    name = 'Replace',
    r = {":SReplace", 'replace'},
    g = {":SReplaceAll", 'replace including all ignored files'},
    s = {":SReplaceAndSave", 'replace and save'},
    a = {":SReplaceAllAndSave", 'replace and save including all ignored files'},
  }
}

return M
