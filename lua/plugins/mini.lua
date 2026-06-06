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

-- require('mini.cursorword').setup()
-- require('mini.pick').setup()
-- require('mini.tabline').setup()
-- require('mini.diff').setup()
-- require('mini.indentscope').setup()
-- require('mini.hipatterns').setup {
-- highlighters = {
--   todo = {
--     pattern = '%f[%w]()TODO()%f[%W]',
--     group = 'MiniHipatternsTodo',
--   },
--   fixme = {
--     pattern = '%f[%w]()FIXME()%f[%W]',
--     group = 'MiniHipatternsFixme',
--   },
--   hack = {
--     pattern = '%f[%w]()HACK()%f[%W]',
--     group = 'MiniHipatternsHack',
--   },
--   note = {
--     pattern = '%f[%w]()NOTE()%f[%W]',
--     group = 'MiniHipatternsNote',
--   },
--
--   hex_color = require('mini.hipatterns').gen_highlighter.hex_color {
--     style = 'background',
--   },
-- },
--
--   delay = {
--     text_change = 200,
--     scroll = 50,
--   },
-- }
-- require('mini.notify').setup {
--   window = {
--     winblend = 0,
--     border = 'rounded',
--     zindex = 50,
--   },
-- }
require('mini.pairs').setup()
-- require('mini.comment').setup()
--
-- require('mini.clue').setup {
--   triggers = {
--     { mode = 'n', keys = '<Leader>' },
--     { mode = 'x', keys = '<Leader>' },
--     { mode = 'n', keys = 'g' },
--     { mode = 'n', keys = 'z' },
--     { mode = 'n', keys = '[' },
--     { mode = 'n', keys = ']' },
--   },
--
--   clues = {
--     { mode = 'n', keys = 'g', desc = 'Go to' },
--     { mode = 'n', keys = '<leader>a', desc = 'Avante' },
--     { mode = 'n', keys = '<leader>b', desc = 'Buffer' },
--     { mode = 'n', keys = '<leader>d', desc = 'DAP' },
--     { mode = 'n', keys = '<leader>c', desc = 'DiffView' },
--     { mode = 'n', keys = '<leader>g', desc = 'Git' },
--     { mode = 'n', keys = '<leader>l', desc = 'Lsp' },
--     { mode = 'n', keys = '<leader>r', desc = 'Overseer tasks' },
--     { mode = 'n', keys = '<leader>f', desc = 'Find' },
--     { mode = 'n', keys = '<leader>t', desc = 'Toggle' },
--     { mode = { 'n', 'v' }, keys = '<leader>h', desc = 'Git Hunk' },
--     { mode = 'n', keys = '<leader>P', desc = 'Picture' },
--     { mode = { 'n', 'v' }, keys = '<leader>x', desc = 'Execute Lua' },
--
--     require('mini.clue').gen_clues.g(),
--     require('mini.clue').gen_clues.z(),
--     require('mini.clue').gen_clues.builtin_completion(),
--     require('mini.clue').gen_clues.marks(),
--   },
-- }
--
-- vim.o.showtabline = 0
-- local function toggle_tabline()
--   if package.loaded['mini.tabline'] then
--     vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
--   else
--     require('mini.tabline').setup()
--     vim.o.showtabline = 2
--   end
-- end
--
-- Keymaps for the 'mini.nvim' plugin
-- local map = function(key, func, desc)
--   vim.keymap.set('n', key, func, { desc = desc })
-- end
--
-- map('<leader>tt', toggle_tabline, 'Toggle tabline')
-- map('<leader>ff', ':Pick files<CR>', 'Smart find file')
-- map('<leader>fh', ':Pick help<CR>', 'Find in help')
-- map('<leader>fw', ':Pick grep<CR>', 'Find content')
-- map('<leader>fW', ':Pick grep_live<CR>', 'Find content(live)')
-- map('<leader>fc', ':e $MYVIMRC<CR>', 'Setting')
-- map('<leader><leader>', ':Pick buffers<CR>', 'Find buffers')
