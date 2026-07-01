_G.Sky = _G.Sky or {}

Sky.packages = {
  sites = {
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/bullets-vim/bullets.vim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/linrongbin16/lsp-progress.nvim' },
    { src = 'https://github.com/stevearc/aerial.nvim' },
    { src = 'https://github.com/stevearc/overseer.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/attilarepka/header.nvim' },
  },

  imports = {
    'ui',
    'lsp',
    'editor',
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
      for _, file in ipairs(Sky.packages.imports) do
        local mod = 'imports.' .. file
        local ok, err = pcall(require, mod)
        if not ok then
          vim.notify(string.format('Failed to load %s:\n%s', mod, err), vim.log.levels.ERROR)
        end
      end
    end,
  })
end
