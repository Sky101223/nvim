return {
  name = 'g++ build',

  builder = function()
    local file = vim.fn.expand '%:p'
    local out = vim.fn.expand '%:p:r' .. '.exe'

    return {
      cmd = {
        'g++',
        '-o',
        out,
        file,
      },
      components = {
        'task_list_on_start',
        'display_duration',
        'on_exit_set_status',
        'on_complete_notify',
      },
    }
  end,

  condition = {
    filetype = { 'cpp' },
  },
}
