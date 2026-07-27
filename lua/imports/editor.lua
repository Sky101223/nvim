-- Gitsigns
require('gitsigns').setup()

-- Snacks
require('snacks').setup {
  git = { enabled = true },
  notifier = {},
  picker = {
    matcher = { frecency = true, cwd_bonus = true, history_bonus = true },
    formatters = { icon_width = 3 },
    find_files = {
      search_dirs = { vim.fn.getcwd() },
    },
    win = {
      input = {
        keys = {
          -- ["<Esc>"] = { "close", mode = { "n", "i" } },
          ['<C-t>'] = { 'edit_tab', mode = { 'n', 'i' } },
        },
      },
    },
  },
  dashboard = {
    enabled = false,
    preset = {
      keys = {
        { icon = '󰈞 ', key = 'f', desc = 'Find files', action = ':lua Snacks.picker.smart()' },
        { icon = ' ', key = 'o', desc = 'Find history', action = ':lua Snacks.picker.recent()' },
        { icon = ' ', key = 'e', desc = 'New file', action = ':enew' },
        { icon = ' ', key = 'M', desc = 'Mason', action = ':Mason' },
        { icon = '', key = 'l', desc = 'LeetCode', action = ':Leet' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
      header = [[
 _______             ____   ____.__         
 \      \   ____  ___\   \ /   /|__| _____  
 /   |   \_/ __ \/  _ \   Y   / |  |/     \ 
/    |    \  ___(  <_> )     /  |  |  Y Y  \
\____|__  /\___  >____/ \___/   |__|__|_|  /
        \/     \/                        \/ 
]],
    },
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
    },
  },
  image = {
    enabled = true,
    doc = { enabled = true, inline = false, float = false, max_width = 80, max_height = 20 },
  },
  indent = {
    enabled = true,
    indent = { enabled = false },
    animate = { duration = { step = 10, duration = 100 } },
    scope = { enabled = true, char = '┊', underline = false, only_current = true, priority = 1000 },
  },
  styles = {
    snacks_image = {
      border = 'rounded',
      backdrop = false,
    },
  },
}
local map = function(key, func, desc)
  vim.keymap.set('n', key, func, { desc = desc })
end
map('<leader>ff', Snacks.picker.smart, 'Smart find file')
map('<leader>fo', Snacks.picker.recent, 'Find recent file')
map('<leader>fw', Snacks.picker.grep, 'Find content')
map('<leader>fh', function()
  Snacks.picker.help { layout = 'dropdown' }
end, 'Find in help')
map('<leader>fl', Snacks.picker.picker_layouts, 'Find picker layout')
map('<leader>fk', function()
  Snacks.picker.keymaps { layout = 'dropdown' }
end, 'Find keymap')
map('<leader><leader>', function()
  Snacks.picker.buffers { sort_lastused = true }
end, 'Find buffers')
map('<leader>fm', Snacks.picker.marks, 'Find mark')
map('<leader>fn', function()
  Snacks.picker.notifications { layout = 'dropdown' }
end, 'Find notification')
map('grr', Snacks.picker.lsp_references, 'Find lsp references')
map('<leader>fS', Snacks.picker.lsp_workspace_symbols, 'Find workspace symbol')
map('<leader>fs', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  local function has_lsp_symbols()
    for _, client in ipairs(clients) do
      if client.server_capabilities.documentSymbolProvider then
        return true
      end
    end
    return false
  end

  if has_lsp_symbols() then
    Snacks.picker.lsp_symbols {
      layout = 'dropdown',
      tree = true,
      on_show = function()
        vim.cmd.stopinsert()
      end,
    }
  else
    Snacks.picker.treesitter()
  end
end, 'Find symbol in current buffer')
map('<leader>fi', Snacks.picker.icons, 'Find icon')
map('<leader>fb', Snacks.picker.lines, 'Find lines in current buffer')
map('<leader>fd', Snacks.picker.diagnostics_buffer, 'Find diagnostic in current buffer')
map('<leader>fH', Snacks.picker.highlights, 'Find highlight')
map('<leader>fc', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, 'Find nvim config file')
map('<leader>f/', Snacks.picker.search_history, 'Find search history')
map('<leader>fj', Snacks.picker.jumps, 'Find jump')
map('<leader>ft', function()
  if vim.bo.filetype == 'markdown' then
    Snacks.picker.grep_buffers {
      finder = 'grep',
      format = 'file',
      prompt = ' ',
      search = '^\\s*- \\[ \\]',
      regex = true,
      live = false,
      args = { '--no-ignore' },
      on_show = function()
        vim.cmd.stopinsert()
      end,
      buffers = false,
      supports_live = false,
      layout = 'ivy',
    }
  else
    Snacks.picker.todo_comments { keywords = { 'NOTE', 'TODO', 'FIX', 'FIXME', 'HACK' }, layout = 'select' }
  end
end, 'Find todo')

map('<leader>fF', function()
  Snacks.picker.lines { search = 'FCN=' }
end)
-- other snacks features
map('<leader>bc', Snacks.bufdelete.delete, 'Delete buffers')
map('<leader>bC', Snacks.bufdelete.other, 'Delete other buffers')
map('<leader>gg', function()
  Snacks.lazygit { cwd = Snacks.git.get_root() }
end, 'Open lazygit')
map('<leader>n', Snacks.notifier.show_history, 'Notification history')
map('<leader>N', Snacks.notifier.hide, 'Notification history')
map('<leader>gb', Snacks.git.blame_line, 'Git blame line')

map('<leader>K', Snacks.image.hover, 'Display image in hover')

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
