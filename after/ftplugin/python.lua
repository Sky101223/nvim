if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true
vim.lsp.enable 'pyright'
-- vim.lsp.enable 'pylsp'
vim.lsp.enable 'ruff'
-- vim.lsp.enable 'yapf'

local opts = { buffer = true }
vim.keymap.set('n', '<localleader>r', ':!python %<CR>', opts)
