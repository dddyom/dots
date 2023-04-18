local M = {}

M.print_opts = {
  prefix = "<leader>",
  expr = true
}

M.v_print_opts = {
  mode='v',
  prefix = "<leader>",
  expr = true
}

M.print_maps = {
  p = {
    name = 'print',
    p = { function() return require('debugprint').debugprint({variable = true}) end, "print variable" },
    P = { function() return require('debugprint').debugprint({variable = true, above = true}) end, "print variable above" },
    c = { function() return require('debugprint').debugprint() end, "check print" },
    C = { function() return require('debugprint').debugprint({above = true}) end, "check print above" },
  },
}

M.v_print_maps = {
  p = {
    name = 'print',
    p = { function() return require('debugprint').debugprint({variable = true}) end, "print selected" },
    P = { function() return require('debugprint').debugprint({variable = true, above = true}) end, "print selected above" },
  },
}
return M
