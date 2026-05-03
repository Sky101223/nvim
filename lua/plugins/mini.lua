vim.pack.add {
  -- { src = 'https://github.com/nvim-mini/mini.ai' },
  -- { src = 'https://github.com/nvim-mini/mini.icons' },
  -- { src = 'https://github.com/nvim-mini/mini.surround' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
}

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
require('mini.tabline').setup()
-- require('mini.statusline').setup()

vim.o.showtabline = 0
local function toggle_tabline()
  if package.loaded['mini.tabline'] then
    vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
  else
    require('mini.tabline').setup()
    vim.o.showtabline = 2
  end
end

local map = function(key, func, desc)
  vim.keymap.set('n', key, func, { desc = desc })
end

map('<leader>tt', toggle_tabline, 'Toggle tabline')
map('<leader>ff', ':Pick files<CR>', 'Smart find file')
map('<leader>fh', ':Pick help<CR>', 'Find in help')
map('<leader>fw', ':Pick grep<CR>', 'Find content')
map('<leader>fW', ':Pick grep_live<CR>', 'Find content(live)')
map('<leader><leader>', ':Pick buffers<CR>', 'Find buffers')
