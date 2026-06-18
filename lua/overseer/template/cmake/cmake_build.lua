return {
  name = 'CMake Build',
  builder = function()
    return {
      cmd = 'cmake',
      args = { '--build', './build' },
      cwd = vim.fn.getcwd(),
    }
  end,
  tags = { 'cmake', 'build' },
  condition = {
    filetype = { 'c', 'cpp', 'h', 'hpp' },
  },
}
