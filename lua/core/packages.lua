_G.Sky = _G.Sky or {}

Sky.packages = {
  sites = {
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    {
      src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
      version = vim.version.range '3',
    },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
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

    { src = 'https://github.com/kawre/leetcode.nvim' },
    { src = 'https://github.com/MunifTanjim/nui.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
  },

  imports = {
    'ui',
    'lsp',
    'editor',
    'practice',
  },
}

Sky.load = function()
  vim.pack.add(Sky.packages.sites, { load = false })

  local success = 0
  local failed = {}
  for _, file in ipairs(Sky.packages.imports) do
    local mod = 'imports.' .. file

    local ok, err = pcall(require, mod)
    if ok then
      success = success + 1
    else
      table.insert(failed, { mod = mod, err = err })
    end

    require(mod)
  end
end
