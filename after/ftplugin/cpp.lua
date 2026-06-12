if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true

if vim.fn.executable 'lcg-clang-format-8.0.0' == 1 then
  vim.keymap.set('n', '<leader>lf', '<cmd>!lcg-clang-format-8.0.0 %<cr>')
else
  vim.lsp.enable 'clang-format'
end

vim.lsp.enable 'clangd'

local map = vim.keymap.set
map('n', '<localleader>r', function()
  local file = vim.fn.expand '%:p'
  local out = vim.fn.expand '%:p:r' .. '.exe'

  local cmd = string.format('g++ -std=c++23 "%s" -o "%s" && cmd /c "%s & pause"', file, out, out)
  vim.cmd('!' .. cmd)
end, { desc = 'Build & Run', buffer = true, silent = true })
map('n', '<localleader>b', function()
  vim.cmd '!g++ -std=c++23 % -o %:r'
end, { desc = 'Build', buffer = true, silent = true })
