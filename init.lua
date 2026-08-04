Sky = {}

Sky.theme = 'nord' --  Current theme

-- Basic Configuration & LSP
for _, core_file in ipairs(require 'core') do
  require(core_file)
end

-- Load all plugins (include theme)
Sky.load()
