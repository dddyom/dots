return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  ---@type opencode.Config
  opts = {
    -- Your configuration, if any
  },
  -- stylua: ignore
  keys = {
    -- opencode.nvim exposes a general, flexible API — customize it to your workflow!
    -- But here are some examples to get you started :)
    { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle opencode', },
    { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = { 'n', 'v' }, },
    { '<leader>oA', function() require('opencode').ask('@file ') end, desc = 'Ask opencode about current file', mode = { 'n', 'v' }, },
    { '<leader>on', function() require('opencode').command('/new') end, desc = 'New session', },
    { '<leader>oe', function() require('opencode').prompt('Объясни @cursor и его контекст') end, desc = 'Explain code near cursor' },
    { '<leader>or', function() require('opencode').prompt('Проверь @file на корректность и читаемость') end, desc = 'Review file', },
    { '<leader>of', function() require('opencode').prompt('Поправь эти ошибки @diagnostics') end, desc = 'Fix errors', },
    { '<leader>oo', function() require('opencode').prompt('Оптимизируй @selection для большей быстроты и читаемости') end, desc = 'Optimize selection', mode = 'v', },
    { '<leader>od', function() require('opencode').prompt('Добавь документацию для @selection на русском языке') end, desc = 'Document selection', mode = 'v', },
    { '<leader>ot', function() require('opencode').prompt('Добавь тесты для @selection') end, desc = 'Test selection', mode = 'v', },
  },
}
