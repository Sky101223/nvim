vim.pack.add {
  { src = 'https://github.com/windwp/nvim-autopairs' },
}

vim.api.nvim_create_autocmd('InsertEnter', {
  group = vim.api.nvim_create_augroup('SetupAutopairs', { clear = true }),
  once = true,
  callback = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'

    npairs.setup {
      enable_check_bracket_line = false,

      fast_wrap = {
        map = '<C-q>',
        chars = { '{', '[', '(', '"', "'", '`' },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },

      disable_filetype = { 'TelescopePrompt' },
    }

    npairs.add_rule(Rule('$', '$', { 'markdown', 'latex', 'tex' }))
    npairs.add_rule(Rule('\\[', '\\]', { 'markdown', 'latex', 'tex' }))
    npairs.add_rule(Rule('[', ']'))
    npairs.add_rule(Rule('(', ')'))
    npairs.add_rule(Rule('{', '}'))
    npairs.add_rule(Rule('"', '"'))
    npairs.add_rule(Rule("'", "'"))
    npairs.add_rule(Rule('`', '`'))
    npairs.add_rule(Rule('``', "''", 'tex'))
    npairs.add_rule(Rule('```', '```', 'markdown'))
    npairs.add_rule(Rule('<!--', '-->', { 'markdown', 'html' }))
    npairs.add_rule(Rule('"""', '"""', 'python'))
    npairs.add_rule(Rule("'''", "'''", 'python'))
    npairs.add_rule(Rule('/*', '*/', { 'c', 'cpp', 'java', 'javascript' }))
    npairs.add_rule(Rule('//', '//', { 'c', 'cpp' }))
  end,
})
