vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('SetupLualine', { clear = true }),
  once = true,
  callback = function()
    require('lualine').setup {
      options = {
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'branch',
            icon = '󰘬',
          },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            colored = true,
          },
        },
        lualine_c = {
          { 'filename', symbols = {
            modified = ' ',
            readonly = ' ',
            unnamed = '',
          } },
        },
        lualine_x = { 'encoding', 'diagnostics' },
        lualine_y = { 'fileformat' },
        lualine_z = { 'filetype' },
      },
    }
  end,
})
