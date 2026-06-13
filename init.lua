Sky = {}

-- Basic Configuration & LSP
for _, core_file in ipairs(require 'core') do
  require(core_file)
end

-- Plugins
Sky.load()

-- Set color
vim.cmd 'colorscheme vague'
vim.cmd.hi 'statusline guibg=NONE'
vim.cmd.hi 'Comment gui=none'
