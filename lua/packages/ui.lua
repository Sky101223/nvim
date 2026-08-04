_G.Sky = _G.Sky or {}

Sky.colorscheme = function(theme)
  if type(theme) ~= 'string' then
    vim.notify('COLORSCHEME need a non-empty string', vim.log.levels.ERROR)
    return
  end

  if theme == 'catppuccin' then
    require 'packages.config.catppuccin' -- Catppuccin
  elseif theme == 'rose-pine' then
    require 'packages.config.rosepine' -- Rose Pine
  elseif theme == 'nord' then
    require 'packages.config.nord' -- Nord
  elseif theme == 'everforest' then
    require 'packages.config.everforest' -- Everforest
  end

  -- Set color
  vim.cmd('colorscheme ' .. theme)
  vim.cmd.hi 'statusline guibg=NONE'

  -- Lualine
  require 'packages.config.lualine'
end
