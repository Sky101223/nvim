return {
  'shaunsingh/nord.nvim',
  priority = 1000,
  enabled = true,
  config = function()
    vim.g.nord_disable_background = true
    require('nord').set()
    vim.cmd.colorscheme 'nord'

    local nord_bg = require('nord.named_colors').none
    vim.api.nvim_set_hl(0, 'WinBar', { bg = nord_bg })
    vim.api.nvim_set_hl(0, 'WinBarNC', { bg = nord_bg })
  end,
}
