return {
  name = 'CMake Generate',
  builder = function()
    local args = {
      '-S',
      '.',
      '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON',
    }

    return {
      cmd = 'cmake',
      args = args,
      cwd = vim.fn.getcwd(),
    }
  end,
  tags = { 'cmake', 'generate' },
  condition = {
    filetype = { 'c', 'cpp', 'h', 'hpp', 'cmake' },
  },
}
