_G.Sky = _G.Sky or {}

Sky.plugins = {
  sites = {
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/shaunsingh/nord.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/bullets-vim/bullets.vim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/linrongbin16/lsp-progress.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvimdev/lspsaga.nvim' },
    { src = 'https://github.com/stevearc/aerial.nvim' },
    { src = 'https://github.com/stevearc/overseer.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  },

  enabled_packs = {
    'vague',
    'conform',
    'overseer',
    'oil',
    'aerial',
    'mini',
    'improve_lsp',
    'gitsigns',
  },
}

Sky.load = function()
  vim.pack.add(Sky.plugins.sites, { load = false })

  local success = 0
  local failed = {}
  for _, file in ipairs(Sky.plugins.enabled_packs) do
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
end
