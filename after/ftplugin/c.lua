if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true

if vim.fn.executable 'lcg-clang-format-8.0.0' == 1 then
  vim.keymap.set('n', '<leader>lf', '<cmd>!lcg-clang-format-8.0.0 %<cr>')
else
  vim.lsp.enable 'clang-format'
end

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.lsp.enable 'clangd'

vim.keymap.set('n', '<localleader>r', function()
  vim.cmd '!gcc -Wall -Wextra % -o %:r && %:r'
end, { buffer = true })
vim.keymap.set('n', '<localleader>b', function()
  vim.cmd '!gcc -Wall -Wextra % -o %:r'
end, { buffer = true, silent = true })
