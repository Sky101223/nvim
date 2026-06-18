-- LeetCode
require('leetcode').setup {
  cn = {
    enabled = false,
    translator = false,
  },
  arg = 'leet',
  lang = 'python',
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
