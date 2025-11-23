return {
  name = 'CMake Configure',
  builder = function(params)
    local build_type = params.build_type or 'Debug'
    local build_dir = params.build_dir or 'build'
    local generator = params.generator or nil
    local extra_args = params.extra_args or {}

    local args = { '-B', build_dir, '-DCMAKE_BUILD_TYPE=' .. build_type }

    if generator then
      table.insert(args, '-G')
      table.insert(args, generator)
    end

    if params.defines then
      for key, value in pairs(params.defines) do
        table.insert(args, '-D' .. key .. '=' .. value)
      end
    end

    for _, arg in ipairs(extra_args) do
      table.insert(args, arg)
    end

    return {
      cmd = { 'cmake' },
      args = args,
      name = 'CMake Configure',
      cwd = vim.fn.getcwd(),
      env = {
        CC = params.cc or 'gcc',
        CXX = params.cxx or 'g++',
      },
      components = { 'default', 'on_output_parse', 'on_complete_notify' },
      metadata = {
        project_type = 'cmake',
        build_dir = build_dir,
        build_type = build_type,
      },
    }
  end,

  condition = {
    callback = function(search)
      return vim.fn.filereadable 'CMakeLists.txt' == 1
    end,
  },
}
