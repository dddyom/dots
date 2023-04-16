vim.g.mapleader = " "
local opts = { silent = true }
local map = vim.keymap.set
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "n", "nzzzv")
map("n", "n", "nzzzv")
map("i", "<c-l>", "<esc>la") -- bend over the bracket
map("n", "<esc><esc>", "<esc>:nohlsearch<cr>", opts)

map("c", "<c-a>", "<home>", {})
map("c", "<c-e>", "<end>", {})

map('n', '<cr>', '@="m`o<c-v><esc>``"<cr>')
map('n', '<S-cr>', '@="m`o<c-v><esc>``"<cr>')

local M = {}

M.insert_opts = {
  mode = "i",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.visual_opts = {
  mode = "v",
  prefix = "",
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

M.surround_opts = {
  mode = "v",
  prefix = ",",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.leader_opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

M.insert_maps = {
  ['<c-w>'] = {"<cmd>lua require('wrapper').wrap_variable()<cr>", "print variable"},
}

M.visual_maps = {
  ['rc'] = {":'<,'>SnipRun<cr>", 'run code'}
}

M.normal_maps = {
  ['H'] = {'<cmd>lua require("harpoon.ui").nav_prev()<CR>', "prev mark"},
  ['L'] = {'<cmd>lua require("harpoon.ui").nav_next()<CR>', "next mark"},
  ['M'] = {'<cmd>lua require("harpoon.mark").add_file()<CR>', 'add mark'},
  ['<c-w>'] = {"<cmd>lua require('wrapper').wrap_under_cursor()<cr>", "print variable"},
}

M.surround_maps = {
  ["t"] = {[[c{% trans %}<c-r>"{% endtrans %}<esc>]], "{% trans %}{% endtrans %}"},
  ["c"] = {[[cconsole.log(<c-r>")<esc>]], "console.log()"},
  ['p'] = {[[cprint(<c-r>")<esc>]], "print()"},
  ['P'] = {[[cprint(f"\033[93m{<c-r>"}\033[0m")<esc>]], "color print"},
  ['%'] = {[[c{% <c-r>" %}<esc>]], "jinja func"},
  ['{'] = {[[c{{ <c-r>" }}<esc>]], "jinja tag"}
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
    p = {'<cmd>bprevious<cr>', 'previous buffer'},
    n = {'<cmd>bnext<cr>', 'next buffer'},
    c = { "<cmd>bd<cr>", "close current buffer" },
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
    name = 'Replace',
    r = {"<cmd>SReplace", 'replace'},
    g = {"<cmd>SReplaceAll", 'replace including all ignored files'},
    s = {"<cmd>SReplaceAndSave", 'replace and save'},
    a = {"<cmd>SReplaceAllAndSave", 'replace and save including all ignored files'},
  }
}

return M
