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
  ["x"] = { "<cmd>ChatGPT<CR>", "chatGPT" },
  ["w"] = { "<cmd>update!<CR>", "save" },
  ["q"] = { "<cmd>q!<CR>", "quit" },
  ["e"] = { ":NeoTreeFocusToggle<cr>", "file explorer" },
  [']'] = { "<cmd>CellularAutomaton make_it_rain<CR>", "rain" },
  ['m'] = {'<cmd>lua require("harpoon.mark").add_file()<CR>', 'add mark'},
  ['M'] = {'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'marks menu'},
  ['h'] = {'<cmd>lua require("harpoon.ui").nav_prev()<CR>', "prev mark"},
  ['l'] = {'<cmd>lua require("harpoon.ui").nav_next()<CR>', "next mark"},
  ['v'] = {"<cmd>:VenvSelect<cr>", 'selecte venv'},
  ['a'] = {"<cmd>AerialToggle!<CR>", 'code structure'},
  f = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "find file" },
    w = {"<cmd>Telescope live_grep<cr>", 'find by word'},
    s = {"<cmd>Telescope grep_string<cr>", 'find by word under cursor'},
    b = {"<cmd>Telescope buffers<cr>", 'find in open buffers'},
    h = {"<cmd>Telescope help_tags<cr>", 'help tags'},
    g = {"<cmd>Telescope git_status<cr>", 'git status'},
    c = {"<cmd>Telescope git_commits<cr>", 'git commits'},
  },
  b = {
    name = 'Buffers',
    c = { ":bd<cr>", "close current buffer" },
    v = { "<c-w>v", "split window vertically" },
    h = { "<c-w>s", "split window horisontally" },
    x = { ":close<cr>", "close current split window" },
    n = { ":tabnew<cr>", "open new tab" }
  },
  g = {
    name = "Git",
    a = {":Git add .<CR>", "add all" },
    s = { ":Git status<CR>", "status" },
    p = { ":Git push<CR>", "push" },
    c = {":Git commit<CR>", "commit"},
    d = {":Gvdiff<CR>", "diff"},
    w = {":Gwrite<CR>", "add current buffer to git"},

  },
  c = {
    name = 'Lspsaga',
    o = {"<cmd>LSoutlineToggle<CR>", 'Outline'},
    c = {"<cmd>Lspsaga code_action<CR>", 'Code actions'},
    r = {"<cmd>Lspsaga rename<CR>", "Rename"},
    d = {"<cmd>Lspsaga show_line_diagnostics<CR>", 'Diagnostic'}
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
