-- LeetCode
require('leetcode').setup {
  cn = {
    enabled = true,
    translator = true,
  },
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
