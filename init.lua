-- Basic Configuration
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Theme
require 'plugins.everforest' -- Color theme
-- require 'plugins.nord' -- Color theme
-- require 'plugins.catppuccin'
require 'plugins.heirline' -- Statusline

-- Language
require 'plugins.treesitter' -- Treesitter
require 'plugins.completion' -- Blink
require 'plugins.autopairs' -- Auto Pair
require 'plugins.conform' -- Conform
require 'plugins.markdown' -- Markdown Language
require 'plugins.meow' -- Helper
require 'plugins.overseer' -- Overseer
require 'plugins.debugging'
require 'config.lsp' -- LSP

-- Editor Layout & Search
require 'plugins.oil' -- File explorer
require 'plugins.comfylnum' -- Jump
require 'plugins.snacks' -- Tools
require 'plugins.which-key' -- Keybinding hints

-- Editing Utilities
require 'plugins.mini' -- Icons
require 'plugins.todo-comments' -- Comments
