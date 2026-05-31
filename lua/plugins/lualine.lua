require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
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
