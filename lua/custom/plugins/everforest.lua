return {
  'neanias/everforest-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('everforest').setup {
      background = 'medium',
      transparent_background_level = 2,
      palette = 'default',
      italics = true,
    }
    vim.cmd.colorscheme 'everforest'
  end,
}
