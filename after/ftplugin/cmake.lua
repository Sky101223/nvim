vim.lsp.start {
  name = 'cmake',
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  settings = {
    ['cmake-language-server'] = {},
  },
  cmd = { 'cmake-language-server' },
  filetypes = { 'cmake' },
  root_markers = {
    'CMakeLists.txt',
    'CMakePresets.json',
    'CTestConfig.cmake',
    '.git',
    'build',
    'cmake',
  },
  init_options = {
    buildDirectory = 'build',
  },
}
