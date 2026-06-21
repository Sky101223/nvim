return {
  name = 'CMake Generate',
  builder = function()
    local args = {
      '-S',
      '.',
      '-B',
      'build',
      '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON',
    }

    table.insert(args, '-G')
    table.insert(args, 'Ninja')

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
