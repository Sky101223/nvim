return {
  name = 'CMake Generate',
  builder = function()
    return {
      cmd = 'cmake',
      args = { '-S', '.', '-B', './build' },
      cwd = vim.fn.getcwd(),
    }
  end,
  tags = { 'cmake', 'generate' },
  condition = {
    filetype = { 'c', 'cpp', 'h', 'hpp' },
  },
}
