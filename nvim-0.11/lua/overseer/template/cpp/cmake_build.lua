return {
  name = 'CMake Build',
  builder = function(params)
    return {
      cmd = { 'cmake' },
      args = { '--build', 'build' },
      name = 'CMake Build',
      cwd = vim.fn.getcwd(),
      env = {
        CC = 'gcc',
        CXX = 'g++',
        CMAKE_BUILD_TYPE = 'Debug',
      },
      components = { 'default', 'on_output_parse', 'on_complete_notify' },
      metadata = {
        project_type = 'cmake',
        build_system = 'CMake',
        target_architecture = 'x64',
      },
    }
  end,
  condition = {
    callback = function(search)
      return vim.fn.filereadable 'CMakeLists.txt' == 1
    end,
  },
}
