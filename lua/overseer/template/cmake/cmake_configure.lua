return {
  name = 'CMake Configure',
  builder = function(params)
    local build_type = params.build_type or 'Debug'
    local build_dir = params.build_dir or 'build'
    local generator = params.generator or 'Ninja'
    local extra_args = params.extra_args or {}

    local args = { '-B', build_dir, '-DCMAKE_BUILD_TYPE=' .. build_type }

    if generator then
      table.insert(args, '-G')
      table.insert(args, generator)
    end

    if params.defines then
      for key, value in pairs(params.defines) do
        table.insert(args, '-D' .. key .. '=' .. tostring(value))
      end
    end

    for _, arg in ipairs(extra_args) do
      table.insert(args, arg)
    end

    return {
      cmd = { 'cmake' },
      args = args,
      name = 'CMake Configure (' .. build_type .. ')',
      cwd = vim.fn.getcwd(),
      env = {
        CC = params.cc or 'gcc',
        CXX = params.cxx or 'g++',
      },
      metadata = {
        project_type = 'cmake',
        build_dir = build_dir,
        build_type = build_type,
      },
    }
  end,

  params = {
    {
      name = 'build_type',
      type = 'choice',
      label = 'Build Type',
      choices = { 'Debug', 'Release', 'RelWithDebInfo', 'MinSizeRel' },
      default = 'Debug',
    },
    {
      name = 'build_dir',
      type = 'string',
      label = 'Build Directory',
      default = 'build',
    },
    {
      name = 'generator',
      type = 'choice',
      label = 'Generator',
      choices = { 'Ninja', 'Unix Makefiles', 'Visual Studio 17 2022', 'Xcode' },
      default = 'Ninja',
    },
    {
      name = 'defines',
      type = 'map',
      label = 'CMake Defines (-D)',
      subtype = 'string',
      default = {},
    },
    {
      name = 'cc',
      type = 'string',
      label = 'C Compiler (CC)',
      default = 'gcc',
    },
    {
      name = 'cxx',
      type = 'string',
      label = 'C++ Compiler (CXX)',
      default = 'g++',
    },
    {
      name = 'extra_args',
      type = 'list',
      label = 'Extra CMake Args',
      subtype = 'string',
      default = {},
    },
  },

  condition = {
    callback = function()
      return vim.fn.filereadable 'CMakeLists.txt' == 1
    end,
  },
}
