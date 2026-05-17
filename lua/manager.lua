local M = {}
local list = {}

M.plugins = {
  -- Color Themes & Statusline
  colors = {
    { src = 'https://github.com/catppuccin/nvim' }, -- Disable
    { src = 'https://github.com/neanias/everforest-nvim' }, -- Disable
    { src = 'https://github.com/vague-theme/vague.nvim' }, -- Enable
    { src = 'https://github.com/shaunsingh/nord.nvim' }, -- Disable
    { src = 'https://github.com/folke/tokyonight.nvim' }, -- Disable

    -- Statusline
    { src = 'https://github.com/rebelot/heirline.nvim' }, -- Enable
  },

  lsp = {
    -- Blink (Enable)
    { src = 'https://github.com/archie-judd/blink-cmp-words' },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' },

    -- Format (Enable)
    { src = 'https://github.com/stevearc/conform.nvim' },

    -- WARN: Debugging (Disable: Some errors)
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
  },

  utils = {
    -- Overseer (Enable)
    { src = 'https://github.com/stevearc/overseer.nvim' },

    -- Tools
    { src = 'https://github.com/nvim-mini/mini.nvim' }, -- Enable
    { src = 'https://github.com/folke/snacks.nvim' }, -- Disable
    { src = 'https://github.com/stevearc/oil.nvim' }, -- Enable
    { src = 'https://github.com/folke/which-key.nvim' }, -- Disable
    { src = 'https://github.com/folke/todo-comments.nvim' }, -- Enable

    -- LeetCode (Enable)
    { src = 'https://github.com/kawre/leetcode.nvim' },
    { src = 'https://github.com/MunifTanjim/nui.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
  },
}

for _, group in pairs(M.plugins) do
  vim.list_extend(list, group)
end

return list
