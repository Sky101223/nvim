require('mason').setup()

require('lspsaga').setup {
  symbol_in_winbar = {
    separator = ' ',
  },
  ui = {
    code_action = '',
  },
  lightbulb = {
    enable = false,
    virtual_text = false,
  },
}
