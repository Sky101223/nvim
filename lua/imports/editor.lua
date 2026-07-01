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
    bash = { glyph = '', hl = 'MiniIconsGreen' },
    sh = { glyph = '', hl = 'MiniIconsGrey' },
    toml = { glyph = '󱄽', hl = 'MiniIconsOrange' },
    cpp = { glyph = '󰙲', hl = 'MiniIconsCyan' },
    c = { glyph = '󰙱', hl = 'MiniIconsCyan' },
  },

  extension = {
    h = { glyph = '󰙱', hl = 'MiniIconsPurple' },
    hpp = { glyph = '󰙲', hl = 'MiniIconsPurple' },
  },
}

-- require('mini.surround').setup {
--   mappings = {
--     add = 'sa', -- Add surrounding in Normal and Visual modes
--     delete = 'sd', -- Delete surrounding
--     find = 'sf', -- Find surrounding (to the right)
--     find_left = 'sF', -- Find surrounding (to the left)
--     highlight = 'sh', -- Highlight surrounding
--     replace = 'sr', -- Replace surrounding
--     update_n_lines = 'sn', -- Update `n_lines`
--
--     suffix_last = 'l', -- Suffix to search with "prev" method
--     suffix_next = 'n', -- Suffix to search with "next" method
--   },
-- }

require('mini.pick').setup()
require('mini.extra').setup()
-- require('mini.git').setup()
-- require('mini.tabline').setup()
-- require('mini.indentscope').setup()
-- require('mini.notify').setup {}
-- require('mini.pairs').setup()
require('mini.comment').setup()

-- Keymaps for the 'mini.nvim' plugin
local map = function(key, func, desc)
  vim.keymap.set('n', key, func, { desc = desc })
end

map('<leader>ff', function()
  MiniPick.builtin.files { tool = 'rg' }
end, 'Pick files')
map('<leader>fw', function()
  MiniPick.builtin.grep_live()
end, 'Pick grep')
map('<leader>fh', function()
  MiniPick.builtin.help()
end, 'Help')
map('<leader><leader>', function()
  MiniPick.builtin.buffers()
end, 'Pick buffers')
map('<leader>fk', function()
  MiniExtra.pickers.keymaps()
end, 'Pick keymaps')
map('<leader>fo', function()
  MiniExtra.pickers.oldfiles()
end, 'Pick recent file')
map('<leader>fd', function()
  MiniExtra.pickers.diagnostic()
end, 'Pick diagnostics')
map('<leader>fm', function()
  MiniExtra.pickers.marks()
end, 'Pick marks')
map('<leader>fH', function()
  MiniExtra.pickers.hl_groups()
end, 'Pick highlight groups')
map('<leader>fch', function()
  MiniExtra.pickers.history()
end, 'Pick command history')
-- map('<leader>fcl', function()
--   MiniExtra.pickers.colorschemes()
-- end, 'Pick colorscheme')

map('<leader>fgb', function()
  MiniExtra.pickers.git_branches()
end, 'Git Branches')
map('<leader>fgc', function()
  MiniExtra.pickers.git_commits()
end, 'Git Commits')
map('<leader>fgf', function()
  MiniExtra.pickers.git_files()
end, 'Git Files')
map('<leader>fgh', function()
  MiniExtra.pickers.git_hunks()
end, 'Git Hunks')

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
  git = {
    show_git_status = true,
    add = function()
      return false
    end,
    mv = function()
      return false
    end,
    rm = function()
      return false
    end,
  },
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

-- Header
local function get_project_name()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ':t')
end

require('header').setup {
  allow_autocmds = true,

  author = 'Haotian Li',
  project = get_project_name(),

  date_created = true,
  date_created_fmt = '%d/%m/%y',

  file_name = true,
  date_modified = false,
  line_separator = '',
  use_block_header = false,
  copyright_text = nil,
  license_from_file = false,
}

map('<leader>h', function()
  require('header').add_header()
end, 'Add header')
