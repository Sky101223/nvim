vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Move cursor down' })
vim.keymap.set('x', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Move cursor down' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Move cursor up' })
vim.keymap.set('x', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Move cursor up' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '\\', '<CMD>:sp<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '|', '<CMD>:vsp<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Go to next qf item' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'Go to prev qf item' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<C-d>', '5j', { desc = 'Scroll down by 5 lines' })
vim.keymap.set('n', '<C-u>', '5k', { desc = 'Scroll up by 5 lines' })
vim.keymap.set('n', 'L', 'gt', { noremap = true, desc = 'Go to next tab' })
vim.keymap.set('n', 'H', 'gT', { noremap = true, desc = 'Go to prev tab' })
vim.keymap.set('n', '<leader>bc', ':bdelete<cr>', { noremap = true, desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { noremap = true, silent = true, desc = 'Go to next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<cr>', { noremap = true, silent = true, desc = 'Go to prev buffer' })
vim.keymap.set('n', '+', '<C-w>|<C-w>_', { desc = 'Maximize nvim pane' })
vim.keymap.set('n', '=', '<C-w>=', { desc = 'Restore nvim panes' })
vim.keymap.set('v', 'p', '"_dP', { noremap = true })
vim.keymap.set('v', '<leader>p', 'p', { noremap = true })
vim.keymap.set('n', '<space>X', '<cmd>source %<cr>', { desc = 'Run this lua file' })
vim.keymap.set('n', '<space>x', ':.lua<cr>', { desc = 'Run this line' })
vim.keymap.set('v', '<space>x', ':lua<cr>', { desc = 'Run selection' })
vim.keymap.set('n', '<leader>tt', function()
  vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
end, { desc = 'Toggle tabline' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action)

local feedkeys = vim.api.nvim_feedkeys
local t = vim.api.nvim_replace_termcodes
vim.keymap.set('n', '<leader>tz', function()
  feedkeys(t('<leader>tg', true, true, true), 'm', false)
  feedkeys(t('<leader>th', true, true, true), 'm', false)
  feedkeys(t('<leader>td', true, true, true), 'm', false)
  feedkeys(t('<leader>tt', true, true, true), 'm', false)
end, { noremap = true, silent = true, desc = 'Toggle distraction free' })

vim.keymap.set('n', '<C-w><C-t>', function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd 'tabnew'
  vim.api.nvim_set_current_buf(buf)
end, { desc = 'Open current buffer in new tab' })

local function jump_to_file_lnum_from_all_windows()
  local matches = {}
  local seen = {}

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    -- Avoid duplicates if multiple windows show the same buffer
    if not seen[buf] then
      seen[buf] = true
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

      for lnum, line in ipairs(lines) do
        for filepath, lno in string.gmatch(line, '([%w%./~_-]+):(%d+)') do
          table.insert(matches, {
            label = filepath .. ':' .. lno,
            file = filepath,
            lnum = tonumber(lno),
          })
        end
      end
    end
  end

  if vim.tbl_isempty(matches) then
    vim.notify('No file:line patterns found in any window', vim.log.levels.INFO)
    return
  end

  vim.ui.select(matches, {
    prompt = 'Jump to file:line',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      vim.cmd('edit ' .. choice.file)
      vim.api.nvim_win_set_cursor(0, { choice.lnum, 0 })
    end
  end)
end

vim.keymap.set('n', '<leader>fJ', jump_to_file_lnum_from_all_windows, { desc = 'Jump to file:line from any window' })

vim.keymap.set('n', '<leader>tp', function()
  local terminals = {
    { name = 'ROOT', cmd = 'bash' },
    { name = 'Python', cmd = 'python3' },
  }
  vim.ui.select(terminals, {
    prompt = 'Pick terminal:',
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if choice then
      vim.cmd('split | terminal ' .. choice.cmd)
      -- name the buffer after its terminal preset
      local buf = vim.api.nvim_get_current_buf()
      local unique_name = 'term:' .. choice.name .. '#' .. buf
      vim.api.nvim_buf_set_name(buf, unique_name)
      vim.b.term_name = choice.name
    end
  end)
end, { desc = 'Pick predefined terminal' })

vim.keymap.set('i', '<C-x><C-d>', function()
  if vim.api.nvim_win_get_config(0).relative == '' then
    return vim.fn.expand '%:p:h'
  else
    -- get window before current one
    local winid = vim.fn.win_getid(vim.fn.winnr '#')
    if winid == 0 then
      return '' -- no previous window
    end
    -- get buffer of that window
    local bufnr = vim.api.nvim_win_get_buf(winid)
    -- expand to directory
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:h')
  end
end, { expr = true, noremap = true })
