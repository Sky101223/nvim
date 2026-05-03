vim.pack.add {
  { src = 'https://github.com/folke/tokyonight.nvim' },
}

require('tokyonight').setup {
  transparent = true,
}

vim.cmd [[colorscheme tokyonight-night]]
vim.cmd.hi 'statusline guibg=NONE'
vim.cmd.hi 'Comment gui=none'
