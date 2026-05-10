vim.keymap.set('n', '<leader>tt', function()
  vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
end, { desc = 'Toggle tabline' })

-- Heirline
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('SetupHeirline', { clear = true }),
  once = true,
  callback = function()
    require('lsp-progress').setup()
    require('heirline').setup {
      statusline = require 'config.heirline.statusline',
      -- tabline = require 'config.heirline.tabline',
    }
  end,
})
