return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  enabled = false,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
      },
    }
    vim.cmd [[colorscheme tokyonight]]
  end,
}
