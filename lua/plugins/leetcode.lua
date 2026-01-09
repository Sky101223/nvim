vim.pack.add {
  { src = 'https://github.com/kawre/leetcode.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
}

require('leetcode').setup {
  arg = 'leet',
  lang = 'cpp',
  injector = {
    ['cpp'] = {
      imports = function()
        return {
          '#include <string>',
          '#include <vector>',
          '',
          'using namespace std;',
        }
      end,
    },
  },
}
