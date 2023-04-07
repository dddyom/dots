local M = {
  'beauwilliams/statusline.lua'
}

M.dependencies = {
  'nvim-lua/lsp-status.nvim'
}

M.config = function ()
  local statusline = require('statusline')
  statusline.tabline = true
  statusline.lsp_diagnostics = true
  statusline.ale_diagnostics = false
  vim.cmd("lua vim.o.laststatus=3")
end

return M
