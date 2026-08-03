-- Mason
require('mason').setup()

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
        json = { 'prettierd' },
        toml = { 'taplo' },
        tex = { 'tex-fmt' },
        cmake = { 'cmakelang' },
        rust = { 'rust-analyzer' },
        go = { 'goimports' },
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

-- Blink
vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = vim.api.nvim_create_augroup('SetupCompletion', { clear = true }),
  once = true,
  callback = function()
    require('blink.cmp').setup {
      fuzzy = { implementation = 'prefer_rust' },

      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = 'single',
            scrollbar = false,
          },
        },

        menu = {
          border = 'single',
          auto_show = true,
          auto_show_delay_ms = 0,
          scrollbar = false,
        },
      },

      keymap = {
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      signature = {
        enabled = true,
      },

      cmdline = {
        completion = {
          menu = {
            auto_show = true,
            -- border = "none",
          },
        },
      },

      term = {
        enabled = true,
      },

      sources = {
        providers = {
          snippets = {
            score_offset = 1000,
            should_show_items = function(ctx) -- avoid triggering snippets after . " ' chars.
              return ctx.trigger.initial_kind ~= 'trigger_character'
            end,
          },
          -- Use the thesaurus source
          thesaurus = {
            name = 'blink-cmp-words',
            module = 'blink-cmp-words.thesaurus',
            -- All available options
            opts = {
              -- A score offset applied to returned items.
              -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
              score_offset = 0,

              -- Default pointers define the lexical relations listed under each definition,
              -- see Pointer Symbols below.
              -- Default is as below ("antonyms", "similar to" and "also see").
              definition_pointers = { '!', '&', '^' },

              -- The pointers that are considered similar words when using the thesaurus,
              -- see Pointer Symbols below.
              -- Default is as below ("similar to", "also see" }
              similarity_pointers = { '&', '^' },

              -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
              -- 2 is similar words of similar words, etc. Increasing this may slow results.
              similarity_depth = 2,
            },
          },

          -- Use the dictionary source
          dictionary = {
            name = 'blink-cmp-words',
            module = 'blink-cmp-words.dictionary',
            -- All available options
            opts = {
              -- The number of characters required to trigger completion.
              -- Set this higher if completion is slow, 3 is default.
              dictionary_search_threshold = 3,

              -- See above
              score_offset = 0,

              -- See above
              definition_pointers = { '!', '&', '^' },
            },
          },
        },
        -- Setup completion by filetype
        per_filetype = {
          text = { 'dictionary' },
          markdown = { 'thesaurus' },
          typst = { 'dictionary', 'thesaurus' },
          tex = { 'dictionary', 'thesaurus' },
        },
      },
    }
  end,
})
