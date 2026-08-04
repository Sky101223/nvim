require('catppuccin').setup {
  flavour = 'mocha',
  styles = {
    keywords = { 'italic' },
    functions = { 'bold' },
  },
  transparent_background = true,
  term_colors = true,
  integrations = {
    aerial = true,
    diffview = true,

    mini = {
      enabled = true,
      indentscope_color = 'sky',
    },

    noice = true,
    overseer = true,
    gitsigns = true,
    flash = true,
    blink_cmp = true,
    mason = true,
    snacks = true,
  },

  highlight_overrides = {
    all = function(mocha)
      return {
        CursorLineNr = { fg = mocha.yellow },
        NormalFloat = { bg = mocha.base },
        FloatBorder = { bg = mocha.base },
        FloatTitle = { bg = mocha.base },
        Pmenu = { bg = mocha.base },
      }
    end,
  },
}
