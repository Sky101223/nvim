-- Vague
require('vague').setup {
  transparent = true,
}

-- Catppuccin
require('catppuccin').setup {
  flavour = 'macchiato',
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

-- One Dark Pro
require('onedarkpro').setup {
  styles = {
    comments = 'italic',
  },
  options = {
    -- cursorline = true,
    transparency = true,
    terminal_colors = true,
  },
}

require('kanagawa').setup {
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = { bold = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  transparent = true,
  dimInactive = false,
  terminalColors = true,
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
}

-- Set color
vim.cmd 'colorscheme kanagawa'
vim.cmd.hi 'statusline guibg=NONE'

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'branch',
        icon = '󰘬',
      },
      'diff',
    },
    lualine_c = {
      {
        'filename',
        path = 1,
      },
      'diagnostics',
    },
    lualine_x = {
      'encoding',
      'fileformat',
      {
        'filetype',
        color = {
          gui = 'bold',
        },
      },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
