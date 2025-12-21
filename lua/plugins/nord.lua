vim.pack.add {
  { src = 'https://github.com/shaunsingh/nord.nvim' },
}

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = true
require('nord').set()

local nord_bg = require('nord.named_colors').none
vim.api.nvim_set_hl(0, 'WinBar', { bg = nord_bg })
vim.api.nvim_set_hl(0, 'WinBarNC', { bg = nord_bg })

vim.cmd.colorscheme 'nord'
