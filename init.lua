-- Basic Configuration
require 'config.autocmds'
require 'config.options'
require 'config.keymaps'

-- Plugins
local plugins = require 'plugins'
vim.pack.add(plugins.sites, { load = false })
for _, file in ipairs(plugins.config_files) do
  local mod = 'plugins.' .. file
  require(mod)
end

-- LSP
require 'config.lsp'

require('vim._core.ui2').enable {
  enable = false,
}

-- Set color
vim.cmd 'colorscheme vague'
vim.cmd.hi 'statusline guibg=NONE'
vim.cmd.hi 'Comment gui=none'
