return {
  capabilities = capabilities,
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
