local utils = require 'heirline.utils'
local colors = require('vague').get_palette()
local components = require 'config.heirline.vague.components'

-- a nice "x" button to close the buffer
local TablineCloseButton = {
  condition = function(self)
    return not vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
  end,
  { provider = ' ' },
  {
    provider = '✗ ',
    hl = function(self)
      return {
        fg = self.is_active and colors.fg or colors.comment,
        bold = self.is_active or self.is_visible,
        italic = self.is_active,
      }
    end,
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
          vim.cmd.redrawtabline()
        end)
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}

-- The final touch!
local TablineBufferLeftIndicator = {
  provider = '┃ ',
  hl = function(self)
    if self.is_active then
      return { fg = colors.keyword, bold = true }
    else
      return { fg = colors.comment, bold = false }
    end
  end,
}
local TablineBufferBlock = {
  TablineBufferLeftIndicator,
  components.TablineFileNameBlock,
  TablineCloseButton,
}

-- and here we go
local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = ' ', hl = { fg = colors.comment } },
  { provider = ' ', hl = { fg = colors.comment } }
)

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == 'neo-tree' then
      self.title = ''
      self.hl = { bg = colors.bg }
      return true
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(' ', pad) .. title .. string.rep(' ', pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return { bg = colors.bg_alt }
    else
      return { bg = colors.bg }
    end
  end,
}

local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
  end,
  hl = function(self)
    if not self.is_active then
      return { fg = colors.comment }
    else
      return { fg = colors.fg }
    end
  end,
}

local TabpageClose = {
  provider = '%999X ✗ %X',
  hl = { fg = colors.comment },
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = '%=' },
  utils.make_tablist(Tabpage),
  TabpageClose,
}

return { TabLineOffset, BufferLine, TabPages }
