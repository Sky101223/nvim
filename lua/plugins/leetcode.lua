-- LeetCode
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
