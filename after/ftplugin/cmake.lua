if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true
vim.lsp.enable 'cmake-language-server'

vim.api.nvim_set_keymap('n', '<localleader>cb', ':!md build && cd build && cmake ..<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<localleader>cc', ':!cmake --build ./build<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<localleader>ct', ':!cd build && ctest<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<localleader>cg', ':!cmake -S . -B build<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<localleader>cc', ':!cmake --build ./build --clean-first<CR>', { silent = true })
