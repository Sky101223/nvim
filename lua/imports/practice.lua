-- LeetCode
require('leetcode').setup {
  cn = {
    enabled = false,
    translator = false,
  },
  arg = 'Leet',
  logging = false,
  lang = 'cpp',
  injector = {
    ['cpp'] = {
      imports = function()
        return {
          '#include <bits/stdc++.h>',
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
