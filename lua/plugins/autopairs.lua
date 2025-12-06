vim.pack.add {
  { src = 'https://github.com/altermo/ultimate-autopair.nvim' },
}

vim.api.nvim_create_autocmd('InsertEnter', {
  group = vim.api.nvim_create_augroup('SetupAutopairs', { clear = true }),
  once = true,
  callback = function()
    require('ultimate-autopair').setup {
      pair_cmap = false,
      tabout = {
        enable = true,
        map = '<C-q>',
        cmap = '<C-q>',
        hopout = true,
      },
      internal_pairs = {
        { '$', '$', suround = true, fly = true, dosuround = true, newline = true, space = true, ft = { 'markdown', 'latex', 'tex' } },
        { '\\[', '\\]', suround = true, fly = true, dosuround = true, newline = true, space = true, ft = { 'markdown', 'latex', 'tex' } },
        { '[', ']', fly = true, dosuround = true, newline = true, space = true },
        { '(', ')', fly = true, dosuround = true, newline = true, space = true },
        { '{', '}', fly = true, dosuround = true, newline = true, space = true },
        { '"', '"', suround = true, multiline = false },
        {
          "'",
          "'",
          suround = true,
          cond = function(fn)
            return not fn.in_lisp() or fn.in_string()
          end,
          alpha = true,
          nft = { 'tex' },
          multiline = false,
        },
        {
          '`',
          '`',
          cond = function(fn)
            return not fn.in_lisp() or fn.in_string()
          end,
          nft = { 'tex' },
          multiline = false,
        },
        { '``', "''", ft = { 'tex' } },
        { '```', '```', newline = true, ft = { 'markdown' } },
        { '<!--', '-->', ft = { 'markdown', 'html' }, space = true },
        { '"""', '"""', newline = true, ft = { 'python' } },
        { "'''", "'''", newline = true, ft = { 'python' } },
      },
    }
  end,
})
