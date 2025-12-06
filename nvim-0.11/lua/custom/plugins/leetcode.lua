return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lang = 'cpp',
    cn = {
      enabled = false,
      translator = true,
    },
    storage = {
      home = vim.fn.stdpath 'data' .. '/leetcode',
      cache = vim.fn.stdpath 'cache' .. '/leetcode',
    },
    compiler = {
      cpp = {
        command = 'g++',
        args = { '-std=c++20', '-O2' },
      },
    },

    picker = { provider = nil },
    logging = true,

    console = {
      open_on_runcode = true, ---@type boolean

      dir = 'row',

      size = {
        width = '90%',
        height = '75%',
      },

      result = {
        size = '60%',
      },

      testcase = {
        virt_text = true, ---@type boolean

        size = '40%',
      },
    },

    cache = {
      update_interval = 60 * 60 * 24 * 3, -- 每3天更新缓存
    },

    hooks = {
      ['enter'] = {},

      ['question_enter'] = {
        function(question)
          if question.lang ~= 'rust' then
            return
          end

          local question_dir = vim.fn.fnamemodify(question:path(), ':h')
          local cargo_file = question_dir .. '/Cargo.toml'

          vim.fn.mkdir(question_dir, 'p')

          local rust_path = question:path()
          rust_path = rust_path:gsub('\\', '/')

          local content = string.format(
            [=[
[package]
name = "leetcode-%s"
version = "0.1.0"
edition = "2021"

[[bin]]
name = "%s"
path = "%s"

[dependencies]
rand = "0.8"
regex = "1"
itertools = "0.14.0"
]=],
            question.q.frontend_id,
            question.q.frontend_id,
            rust_path
          )

          local file = io.open(cargo_file, 'w')
          if file then
            file:write(content)
            file:close()
            print('Cargo.toml created at: ' .. cargo_file)
          else
            print('Failed to open file: ' .. cargo_file)
          end
        end,
      },

      ['leave'] = {},
    },

    injector = {
      ['rust'] = {
        before = {
          '#[allow(dead_code)]',
          'fn main() {',
          '   // TODO: You can write something...',
          '}',

          '#[allow(dead_code)]',
          'struct Solution;',
        },
      },

      ['cpp'] = {
        before = {
          '#include <algorithm>',
          '#include <string>',
          '#include <vector>',
          '',
          'using std::string;',
          'using std::vector;',
        },
      },
    },

    keys = {
      toggle = { 'q' },
      confirm = { '<CR>' },

      reset_testcases = 'r',
      use_testcase = 'U',
      focus_testcases = 'H',
      focus_result = 'L',
    },

    render = {
      browser = {},
    },

    plugins = {
      non_standalone = false,
    },

    theme = {},
    image_support = false,
  },
}
