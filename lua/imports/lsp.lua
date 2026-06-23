-- Mason
require('mason').setup()

-- Lspsaga
-- require('lspsaga').setup {
--   symbol_in_winbar = {
--     separator = ' ',
--   },
--   ui = {
--     code_action = '',
--   },
--   lightbulb = {
--     enable = false,
--     virtual_text = false,
--   },
-- }

-- Outline
require('aerial').setup {
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
}
vim.keymap.set('n', '<leader>o', ':AerialToggle!<CR>', { desc = 'Outline' })

-- Formatting
vim.g.disable_autoformat = false
vim.keymap.set('n', '<leader>tf', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    vim.notify('Autoformat is enabled', vim.log.levels.INFO)
  else
    vim.g.disable_autoformat = true
    vim.notify('Autoformat is disabled', vim.log.levels.WARN)
  end
end, { desc = 'Toggle autoformatting' })

-- Conform
vim.api.nvim_create_autocmd({ 'BufWritePre', 'InsertEnter' }, {
  group = vim.api.nvim_create_augroup('SetupConform', { clear = true }),
  once = true,
  callback = function()
    require('conform').setup {
      notify_on_error = true,
      format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 5000,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = function()
          if vim.fn.executable 'lcg-clang-format-8.0.0' == 1 then
            return { 'lcg_clang_format' }
          else
            return { 'clang-format' }
          end
        end,
        c = function()
          if vim.fn.executable 'lcg-clang-format-8.0.0' == 1 then
            return { 'lcg_clang_format' }
          else
            return { 'clang-format' }
          end
        end,
        -- python = { 'yapf', 'isort' },
        python = { 'ruff' },
        markdown = { 'prettierd', 'cbfmt' },
        typst = { 'typstyle' },
        nix = { 'nixfmt' },
        json = { 'prettierd' },
        toml = { 'taplo' },
        tex = { 'tex-fmt' },
        cmake = { 'cmakelang' },
        rust = { 'rust-analyzer' },
        cangjie = { 'cjfmt' },
      },
      formatters = {
        cbfmt = { command = 'cbfmt', args = { '-w', '--config', vim.fn.expand '~' .. '/.config/cbfmt.toml', '$FILENAME' } },
        taplo = { command = 'taplo', args = { 'fmt', '--option', 'indent_tables=false', '-' } },
        ruff = {
          command = 'ruff',
          args = { 'format', '--stdin-filename', '$FILENAME', '-' },
          stdin = true,
        },
        lcg_clang_format = { command = 'lcg-clang-format-8.0.0', args = { '$FILENAME' } },
        cjfmt = {
          command = 'cjfmt',
          args = { '-f', '$FILENAME' },
          stdin = false,
        },
      },
    }
  end,
})

vim.api.nvim_create_user_command('ConformDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('ConformEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- Cangjie LSP
require('cangjie-nvim').setup {
  auto_install = true,
}

vim.filetype.add {
  extension = {
    cj = 'cangjie',
  },
}
