Sky = {}

-- Basic Configuration & LSP
for _, core_file in ipairs(require 'core') do
  require(core_file)
end

-- Load all plugins
Sky.load()
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    if type(Sky.colorscheme) == 'function' then
      Sky.colorscheme 'nord'
    else
      vim.notify('Sky.colorscheme is not defined', vim.log.levels.ERROR)
    end
  end,
})
