local function get_project_name()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ':t')
end

require('header').setup {
  allow_autocmds = true,

  author = 'Haotian Li',
  project = get_project_name(),

  date_created = true,
  date_created_fmt = '%d/%m/%y',

  file_name = true,
  date_modified = false,
  line_separator = '',
  use_block_header = false,
  copyright_text = nil,
  license_from_file = false,
}

vim.keymap.set('n', '<leader>h', function()
  require('header').add_header()
end, { desc = 'Add header' })
