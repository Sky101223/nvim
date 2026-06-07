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

-- require('mini.pick').setup()
-- require('mini.git').setup()
require('mini.tabline').setup()
-- require('mini.indentscope').setup()
-- require('mini.notify').setup {
--   window = {
--     winblend = 0,
--     border = 'rounded',
--     zindex = 50,
--   },
-- }
require('mini.pairs').setup()
-- require('mini.comment').setup()

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
-- map('<leader>ff', ':Pick files<CR>', 'Smart find file')
-- map('<leader>fh', ':Pick help<CR>', 'Find in help')
-- map('<leader>fw', ':Pick grep<CR>', 'Find content')
-- map('<leader>fW', ':Pick grep_live<CR>', 'Find content(live)')
-- map('<leader>fc', ':e $MYVIMRC<CR>', 'Setting')
-- map('<leader>gb', function()
--   require('mini.git').show_at_cursor()
-- end, 'Git blame line (mini.git)')
-- map('<leader>gg', function()
--   vim.cmd 'terminal lazygit'
--   vim.wo.winfixheight = true
--   vim.bo.filetype = 'lazygit'
-- end, 'Open LazyGit in terminal')
-- map('<leader><leader>', ':Pick buffers<CR>', 'Find buffers')
