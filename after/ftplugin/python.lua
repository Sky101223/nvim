if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true
vim.lsp.enable 'basedpyright'
vim.lsp.enable 'ruff'

local opts = { buffer = true }
vim.keymap.set('n', '<localleader>r', ':!python %<CR>', opts)
vim.keymap.set('n', '<localleader>t', ':!pytest %<CR>', opts)
vim.keymap.set('n', '<localleader>T', ':!pytest<CR>', opts)
vim.keymap.set('n', '<localleader>i', ':terminal python<CR>', opts)
vim.keymap.set('n', '<localleader>f', ':!ruff format %<CR>', opts)
vim.keymap.set('n', '<localleader>c', ':!ruff check %<CR>', opts)
