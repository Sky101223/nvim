require('mini.ai').setup {
  mappings = {
    goto_left = '[',
    got_right = ']',
  },
}

require('mini.icons').setup {
  style = 'glyph',
  file = {
    README = { glyph = '󰆈', hl = 'MiniIconsYellow' },
    ['README.md'] = { glyph = '󰆈', hl = 'MiniIconsYellow' },
  },
  filetype = {
    bash = { glyph = '', hl = 'MiniIconsGreen' },
    sh = { glyph = '', hl = 'MiniIconsGrey' },
    toml = { glyph = '󱄽', hl = 'MiniIconsOrange' },
    cpp = { glyph = '󰙲', hl = 'MiniIconsCyan' },
    c = { glyph = '󰙱', hl = 'MiniIconsCyan' },
  },

  extension = {
    h = { glyph = '󰙱', hl = 'MiniIconsPurple' },
    hpp = { glyph = '󰙲', hl = 'MiniIconsPurple' },
  },
}
