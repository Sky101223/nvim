if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.lsp.enable 'cjls'
vim.lsp.enable 'cjfmt'
