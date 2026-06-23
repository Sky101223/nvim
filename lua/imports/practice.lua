-- LeetCode
require('leetcode').setup {
  cn = {
    enabled = false,
    translator = false,
  },
  arg = 'Leet',
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

    ['c'] = {
      imports = function()
        return {
          '#include <stdlib.h>',
          '',
        }
      end,
    },
  },
}
