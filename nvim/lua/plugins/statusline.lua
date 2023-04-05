local M = {
  'beauwilliams/statusline.lua'
}
M.config = function ()
  local statusline = require('statusline')
  statusline.tabline = true
  statusline.lsp_diagnostics = true
  statusline.ale_diagnostics = false
end

return M
