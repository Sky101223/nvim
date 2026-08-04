local overseer = require 'overseer'

-- overseer.config
overseer.setup {
  template_timeout = 8000,
  templates = {
    'builtin',
    'cmake',
    'python',
    'grun_option',
    'run_script',
  },
  component_aliases = {
    default = {
      'on_exit_set_status',
      'on_complete_notify',
    },
    default_vscode = {
      'default',
      'task_list_on_start',
      'on_output_quickfix',
      'unique',
    },
  },
  task_list = {
    direction = 'right',
    bindings = {
      ['o'] = false,
      ['+'] = 'IncreaseDetail',
      ['_'] = 'DecreaseDetail',
      ['='] = 'IncreaseAllDetail',
      ['-'] = 'DecreaseAllDetail',
      ['k'] = 'PrevTask',
      ['j'] = 'NextTask',
      ['t'] = '<CMD>OverseerQuickAction open tab<CR>',
      ['<C-u>'] = false,
      ['<C-d>'] = false,
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
    },
  },
}

-- overseer template hooks
overseer.add_template_hook({
  module = '^make$',
}, function(task_defn, util)
  util.add_component(task_defn, 'task_list_on_start')
  util.add_component(task_defn, { 'on_output_write_file', filename = task_defn.cmd[1] .. '.log' })
  util.add_component(task_defn, { 'on_output_quickfix', open_on_exit = 'failure' })
  util.add_component(task_defn, 'on_complete_notify')
  util.add_component(task_defn, 'unique')
end)

overseer.add_template_hook({
  module = '^remake Fit$',
}, function(task_defn, util)
  util.add_component(task_defn, 'unique')
end)

-- keymaps
vim.keymap.set('n', '<Leader>rl', '<cmd>OverseerRun<cr>', { desc = 'Overseer run templates' })
local toggle_overseer = function()
  vim.cmd 'OverseerToggle'
  Sky.func_on_window('dapui_stacks', function()
    require('dapui').open { reset = true }
  end)
end
vim.keymap.set('n', '<Leader>ro', toggle_overseer, { desc = 'Overseer toggle task list' })
vim.keymap.set('n', '<C-\\>', toggle_overseer, { desc = 'Overseer toggle task list' })
vim.keymap.set('n', '<Leader>ra', '<cmd>OverseerQuickAction<cr>', { desc = 'Overseer quick action list' })

-- autocmds
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'OverseerList',
  callback = function()
    vim.opt_local.winfixbuf = true
  end,
})
