-- Plugins
vim.pack.add(require 'manager', { load = false })

-- Basic Configuration
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Themes & Statusline
require 'plugins.everforest'
require 'plugins.kanagawa'
require 'plugins.vague'
-- require 'plugins.nord'
require 'plugins.catppuccin'
require 'plugins.nightfox'
-- require 'plugins.heirline'
require 'plugins.lualine'
require 'plugins.tokyonight'

-- Language
-- require 'plugins.completion' -- Blink
-- require 'plugins.autopairs' -- Auto Pair
require 'plugins.conform' -- Conform
require 'plugins.overseer' -- Overseer
require 'plugins.debugging' -- Debug
require 'config.lsp' -- LSP

-- Editor Layout & Search
require 'plugins.oil' -- File explorer
-- require 'plugins.pdf' -- PDF
require 'plugins.snacks' -- Tools
require 'plugins.mini' -- Tools
-- require 'plugins.which-key' -- Keybinding hints

-- Editing Utilities
-- require 'plugins.comments' -- Comments
require 'plugins.leetcode' -- LeetCode

require 'plugins.gitsigns' -- Git

require('vim._core.ui2').enable {
  enable = false,
}

-- Set color
vim.cmd 'colorscheme vague'
vim.cmd.hi 'statusline guibg=NONE'
vim.cmd.hi 'Comment gui=none'
