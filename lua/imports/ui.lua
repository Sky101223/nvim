-- Vague
require('vague').setup {
  transparent = true,
}

-- Catppuccin
require('catppuccin').setup {
  flavour = 'mocha',
  -- flavour = 'latte',
  styles = {
    -- keywords = { 'italic' },
    -- functions = { 'bold' },
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
    mocha = function(mocha)
      return {
        CursorLineNr = { fg = mocha.yellow },
        TelescopeSelection = { bg = mocha.surface0 },
        TelescopeSelectionCaret = { fg = mocha.yellow, bg = mocha.surface0 },
        TelescopePromptPrefix = { fg = mocha.yellow },
        FlashCurrent = { bg = mocha.peach, fg = mocha.base },
        FlashMatch = { bg = mocha.red, fg = mocha.base },
        FlashLabel = { bg = mocha.teal, fg = mocha.base },
        NormalFloat = { bg = mocha.base },
        FloatBorder = { bg = mocha.base },
        FloatTitle = { bg = mocha.base },
        RenderMarkdownCode = { bg = mocha.crust },
        Pmenu = { bg = mocha.base },
      }
    end,
  },
}

-- One Dark Pro
require('onedarkpro').setup {
  styles = {
    comments = 'italic',
  },
  options = {
    cursorline = true,
    transparency = true,
    terminal_colors = true,
  },
}

-- Set color
vim.cmd 'colorscheme vague'
vim.cmd.hi 'statusline guibg=NONE'
