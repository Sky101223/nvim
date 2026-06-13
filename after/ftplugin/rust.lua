if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true

vim.lsp.enable 'rust-analyzer'
vim.keymap.set('n', '<localleader>r', function()
  vim.cmd 'w'
  vim.cmd 'botright 10split | terminal cargo run'
  vim.cmd 'startinsert'
end, { desc = 'Rust: cargo run' })

vim.keymap.set('n', '<localleader>b', function()
  vim.cmd 'w'
  vim.cmd 'botright rightbelow 10split | terminal cargo build'
  vim.cmd 'startinsert'
end, { desc = 'Rust: cargo build' })

vim.keymap.set('n', '<localleader>t', function()
  vim.cmd 'w'
  vim.cmd 'botright rightbelow 10split | terminal cargo test'
  vim.cmd 'startinsert'
end, { desc = 'Rust: cargo test' })
