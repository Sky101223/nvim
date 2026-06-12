-- Basic Configuration & LSP
for _, config in ipairs(require 'core') do
  require(config)
end

-- Plugins
local plugins = require 'plugins'
vim.pack.add(plugins.sites, { load = false })
local success = 0
local failed = {}
for _, file in ipairs(plugins.config_files) do
  local mod = 'plugins.' .. file

  local ok, err = pcall(require, mod)
  if ok then
    success = success + 1
  else
    table.insert(failed, { mod = mod, err = err })
  end

  require(mod)
end
vim.notify(string.format('󰄬  %d plugins loaded', success), vim.log.levels.INFO, { title = 'Plugin Loader' })
if #failed ~= 0 then
  vim.notify(string.format('  Failed to load %d plugins', #failed), vim.log.levels.ERROR, { title = 'Plugin Loader' })

  for _, f in ipairs(failed) do
    vim.notify(string.format('  %s', f.mod), vim.log.levels.ERROR)
  end
end

require('vim._core.ui2').enable {
  enable = true,
}

-- Set color
vim.cmd 'colorscheme vague'
vim.cmd.hi 'statusline guibg=NONE'
vim.cmd.hi 'Comment gui=none'
