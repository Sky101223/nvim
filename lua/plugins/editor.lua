-- Gitsigns
require('gitsigns').setup()

-- Mini
require('mini.ai').setup {
  mappings = {
    goto_left = '[',
    got_right = ']',
  },
}

require('mini.icons').setup {
  style = 'glyph',
  file = {
    README = { glyph = '󰆈', hl = 'MiniIconsYellow' },
    ['README.md'] = { glyph = '󰆈', hl = 'MiniIconsYellow' },
  },
  filetype = {
    bash = { glyph = '󱆃', hl = 'MiniIconsGreen' },
    sh = { glyph = '󱆃', hl = 'MiniIconsGrey' },
    toml = { glyph = '󱄽', hl = 'MiniIconsOrange' },
  },
}

require('mini.surround').setup {
  mappings = {
    add = 'sa', -- Add surrounding in Normal and Visual modes
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}

require('mini.pick').setup()
-- require('mini.git').setup()
require('mini.tabline').setup()
require('mini.indentscope').setup()
require('mini.notify').setup {
  window = {
    winblend = 0,
    border = 'rounded',
    zindex = 50,
  },
  lsp_progress = {
    enable = false,
  },
}
require('mini.pairs').setup()
require('mini.comment').setup()

vim.o.showtabline = 0
local function toggle_tabline()
  if package.loaded['mini.tabline'] then
    vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
  else
    require('mini.tabline').setup()
    vim.o.showtabline = 2
  end
end

-- Keymaps for the 'mini.nvim' plugin
local map = function(key, func, desc)
  vim.keymap.set('n', key, func, { desc = desc })
end

map('<leader>tt', toggle_tabline, 'Toggle tabline')
map('<leader>ff', ':Pick files<CR>', 'Smart find file')
map('<leader>fh', ':Pick help<CR>', 'Find in help')
map('<leader>fw', ':Pick grep<CR>', 'Find content')
map('<leader>fW', ':Pick grep_live<CR>', 'Find content(live)')
map('<leader>ec', ':e $MYVIMRC<CR>', 'Setting')
map('<leader>gb', function()
  require('mini.git').show_at_cursor()
end, 'Git blame line (mini.git)')
map('<leader>gg', function()
  vim.cmd 'terminal lazygit'
  vim.wo.winfixheight = true
  vim.bo.filetype = 'lazygit'
end, 'Open LazyGit in terminal')
map('<leader><leader>', ':Pick buffers<CR>', 'Find buffers')

-- Oil
function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local detail = false
require('oil').setup {
  default_file_explorer = true,
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-k>'] = false,
    ['<C-j>'] = false,
    ['<C-r>'] = 'actions.refresh',
    ['<leader>y'] = 'actions.yank_entry',
    ['g.'] = false,
    ['zh'] = 'actions.toggle_hidden',
    ['\\'] = { 'actions.select', opts = { horizontal = true } },
    ['|'] = { 'actions.select', opts = { vertical = true } },
    ['-'] = 'actions.close',
    ['<leader>e'] = 'actions.close',
    ['<BS>'] = 'actions.parent',
    ['gd'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
  },
  win_options = {
    winbar = '%!v:lua.get_oil_winbar()',
  },
}
vim.keymap.set('n', '-', ':Oil<CR>')

-- Overseer
local overseer = require 'overseer'

-- overseer.config
overseer.setup {
  template_timeout = 8000,
  templates = {
    'builtin',
    'python',
    'grun_option',
    'run_script',
    'cpp',
    -- 'cmake',
  },
  component_aliases = {
    default = {
      { 'display_duration', detail_level = 1 },
      'on_output_summarize',
      'on_exit_set_status',
      'on_complete_notify',
    },
    default_vscode = {
      'default',
      'display_duration',
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
  util.add_component(task_defn, { 'display_duration', detail_level = 1 })
  util.add_component(task_defn, 'unique')
  util.remove_component(task_defn, 'on_output_summarize')
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
