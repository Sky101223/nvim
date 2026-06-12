-- Heirline
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('SetupHeirline', { clear = true }),
  once = true,
  callback = function()
    local config = require 'config.heirline'
    require('lsp-progress').setup()
    require('heirline').setup {
      statusline = config.statusline,
      tabline = config.tabline,
    }
  end,
})
