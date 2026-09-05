_G.Sky = _G.Sky or {}

Sky.packages = {
  sites = {
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/rose-pine/neovim' },
    { src = 'https://github.com/shaunsingh/nord.nvim' },
    { src = 'https://github.com/sainnhe/everforest' },

    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/archie-judd/blink-cmp-words' },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/bullets-vim/bullets.vim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/linrongbin16/lsp-progress.nvim' },
    { src = 'https://github.com/stevearc/overseer.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/attilarepka/header.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  },

  modules = {
    'lsp',
    'editor',
    'ui',
  },
}

Sky.load = function()
  vim.pack.add(Sky.packages.sites, {
    dir = vim.fn.stdpath 'data' .. '/site/pack',
    load = false,
  })
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.cmd 'packloadall!'

      for _, file in ipairs(Sky.packages.modules) do
        local mod = 'packages.' .. file
        local ok, err = pcall(require, mod)
        if not ok then
          vim.notify(string.format('Failed to load %s:\n%s', mod, err), vim.log.levels.ERROR)
        end
      end

      Sky.colorscheme(Sky.theme) -- Set Theme
    end,
  })
end
