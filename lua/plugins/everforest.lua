vim.pack.add({
    { src = "https://github.com/neanias/everforest-nvim" }
})

require('everforest').setup {
  background = 'hard',
  transparent_background_level = 2,
  palette = 'default',
  italics = true,
}
vim.cmd.colorscheme 'everforest'
