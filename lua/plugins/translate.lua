vim.pack.add {
  { src = 'https://github.com/JuanZoran/Trans.nvim' },
  { src = 'https://github.com/kkharji/sqlite.lua' },
}

require('Trans').setup {
  dict = {
    auto_install = true,
    path = vim.fn.stdpath 'data' .. '/Trans/dict/',
  },
}

require('Trans').install()

vim.keymap.set({ 'n', 'x' }, '<leader>mm', '<Cmd>Translate<CR>', { desc = '󰊿 Translate' })
vim.keymap.set({ 'n', 'x' }, '<leader>mk', '<Cmd>TransPlay<CR>', { desc = ' Auto Play' })
