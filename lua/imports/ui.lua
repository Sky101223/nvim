_G.Sky = _G.Sky or {}

Sky.colorscheme = function(theme)
  if type(theme) ~= 'string' then
    vim.notify('COLORSCHEME need a non-empty string', vim.log.levels.ERROR)
    return
  end

  if theme == 'catppuccin' then -- [[Catppuccin]]
    require('catppuccin').setup {
      flavour = 'mocha',
      styles = {
        keywords = { 'italic' },
        functions = { 'bold' },
      },
      transparent_background = true,
      term_colors = true,
      integrations = {
        aerial = true,
        diffview = true,

        mini = {
          enabled = true,
          indentscope_color = 'sky',
        },

        noice = true,
        overseer = true,
        gitsigns = true,
        flash = true,
        blink_cmp = true,
        mason = true,
        snacks = true,
      },

      highlight_overrides = {
        all = function(mocha)
          return {
            CursorLineNr = { fg = mocha.yellow },
            NormalFloat = { bg = mocha.base },
            FloatBorder = { bg = mocha.base },
            FloatTitle = { bg = mocha.base },
            Pmenu = { bg = mocha.base },
          }
        end,
      },
    }
  elseif theme == 'rose-pine' then -- [[Rose pine]]
    require('rose-pine').setup {
      variant = 'main',

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    }
  elseif theme == 'nord' then -- [[Nord]]
    vim.g.nord_disable_background = false
    vim.g.nord_italic = false
    vim.g.nord_bold = false
    vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })
  elseif theme == 'everforest' then -- [[Everforest]]
    vim.g.everforest_background = 'hard'
    vim.g.everforest_transparent_background = 2
  end

  -- Set color
  vim.cmd('colorscheme ' .. theme)
  vim.cmd.hi 'statusline guibg=NONE'

  -- Lualine
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          icon = '󰘬',
        },
        'diff',
      },
      lualine_c = {
        {
          'filename',
          path = 1,
        },
        'diagnostics',
      },
      lualine_x = {
        'encoding',
        'fileformat',
        {
          'filetype',
          color = {
            gui = 'bold',
          },
        },
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  }
end
