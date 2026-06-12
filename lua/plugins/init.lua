local plugins = {}

plugins.sites = {
  -- Color Themes & Statusline
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/neanias/everforest-nvim' },
  { src = 'https://github.com/vague-theme/vague.nvim' },
  { src = 'https://github.com/shaunsingh/nord.nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/rebelot/kanagawa.nvim' },
  { src = 'https://github.com/EdenEast/nightfox.nvim' },

  -- Statusline
  { src = 'https://github.com/rebelot/heirline.nvim' }, -- Disable
  { src = 'https://github.com/nvim-lualine/lualine.nvim' }, -- Enable

  -- Blink (Enable)
  { src = 'https://github.com/archie-judd/blink-cmp-words' },
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' },

  -- Format (Enable)
  { src = 'https://github.com/stevearc/conform.nvim' },

  -- FIXME Debugging (Disable: Some errors)
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/theHamsta/nvim-dap-virtual-text' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
  -- { src = 'https://github.com/nvim-dap/dap-gdb' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/mfussenegger/nvim-dap-python' },

  -- Lsp Progress
  { src = 'https://github.com/linrongbin16/lsp-progress.nvim' },

  -- Markdown Language (Enable)
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  { src = 'https://github.com/bullets-vim/bullets.vim' },

  -- Pairs (Enable)
  { src = 'https://github.com/windwp/nvim-autopairs' },

  -- lsp
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvimdev/lspsaga.nvim' },
  { src = 'https://github.com/stevearc/aerial.nvim' },

  -- Overseer (Enable)
  { src = 'https://github.com/stevearc/overseer.nvim' },

  -- Tools
  { src = 'https://github.com/nvim-mini/mini.nvim' }, -- Enable
  { src = 'https://github.com/folke/snacks.nvim' }, -- Disable
  { src = 'https://github.com/stevearc/oil.nvim' }, -- Enable
  { src = 'https://github.com/folke/which-key.nvim' }, -- Disable
  { src = 'https://github.com/folke/todo-comments.nvim' }, -- Enable
  -- { src = 'https://github.com/paddywz/doxycpp.nvim' }, -- Enable
  -- { src = 'https://github.com/r-pletnev/pdfreader.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  -- LeetCode (Enable)
  { src = 'https://github.com/kawre/leetcode.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
}

plugins.config_files = {
  'vague',
  -- 'lualine',
  'heirline',
  'conform',
  'overseer',
  'oil',
  'aerial',
  'mini',
  'improve_lsp',
  'leetcode',
  'gitsigns',
}

return plugins
