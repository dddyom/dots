local M = {}


M.surround_opts = {
  mode = "v",
  prefix = ",",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
M.surround_maps = {
  ["t"] = {[[c{% trans %}<c-r>"{% endtrans %}<esc>]], "{% trans %}{% endtrans %}"},
  ['%'] = {[[c{% <c-r>" %}<esc>]], "jinja func"},
  ['{'] = {[[c{{ <c-r>" }}<esc>]], "jinja tag"}
}

return M
