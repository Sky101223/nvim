return {
  name = 'CMake Test',
  builder = function()
    return {
      cmd = 'ctest',
      args = { '--test-dir', './build' },
      cwd = vim.fn.getcwd(),
    }
  end,
  tags = { 'cmake', 'test' },
  condition = {
    filetype = { 'c', 'cpp', 'h', 'hpp' },
  },
}
