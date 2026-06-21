Sky = Sky or {}
-- require 'core.snippets'

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    spacing = 4,
    prefix = '',
    source = 'if_many',
  },
  update_in_insert = false,
  float = {
    enabled = true,
    severity_sort = true,
    source = 'if_many',
    border = 'single',
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
      -- [vim.diagnostic.severity.ERROR] = '',
      -- [vim.diagnostic.severity.WARN] = '',
      -- [vim.diagnostic.severity.INFO] = '',
      -- [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.INFO] = 'InfoFloat',
      [vim.diagnostic.severity.HINT] = 'HintFloat',
    },
  },
}

vim.opt.pumheight = 12
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('SetupLSP', {}),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- [completion]
    if client:supports_method 'textDocument/completion' then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end

      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = true,
        -- convert = function(item)
        --   local label = item.label or ""
        --   local MAX_WIDTH = 30
        --   local ellipsis = "…"
        --
        --   local abbr
        --   if vim.fn.strdisplaywidth(label) > MAX_WIDTH then
        --     abbr = vim.fn.strcharpart(label, 0, MAX_WIDTH - 1) .. ellipsis
        --   else
        --     abbr = label
        --   end
        --
        --   return {
        --     word = item.insertText or label,
        --     abbr = abbr,
        --     kind = item.kind,
        --     menu = item.detail or "",
        --   }
        -- end,
      })
    end

    -- [inlay hint]
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
    end

    -- [folding]
    if client and client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- [keymaps]
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
    vim.keymap.set('n', 'gd', function()
      local params = vim.lsp.util.make_position_params(0, 'utf-8')
      vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result, _, _)
        if not result or vim.tbl_isempty(result) then
          vim.notify('No definition found', vim.log.levels.INFO)
        else
          vim.lsp.buf.definition()
        end
      end)
    end, { buffer = event.buf, desc = 'LSP: Goto Definition' })
    vim.keymap.set('i', '<C-y>', function()
      if vim.fn.pumvisible() == 1 then
        return '<C-y>'
      else
        return '<C-y>'
      end
    end, { expr = true, desc = 'Confirm LSP completion' })
    vim.keymap.set('n', 'gD', function()
      local win = vim.api.nvim_get_current_win()
      local width = vim.api.nvim_win_get_width(win)
      local height = vim.api.nvim_win_get_height(win)

      -- Mimic tmux formula: 8 * width - 20 * height
      local value = 8 * width - 20 * height
      if value < 0 then
        vim.cmd 'split' -- vertical space is more: horizontal split
      else
        vim.cmd 'vsplit' -- horizontal space is more: vertical split
      end

      vim.lsp.buf.definition()
    end, { buffer = event.buf, desc = 'LSP: Goto Definition (split)' })

    local function jump_to_current_function_start()
      local params = { textDocument = vim.lsp.util.make_text_document_params() }
      local responses = vim.lsp.buf_request_sync(0, 'textDocument/documentSymbol', params, 1000)
      if not responses then
        return
      end

      local pos = vim.api.nvim_win_get_cursor(0)
      local line = pos[1] - 1

      local function find_symbol(symbols)
        for _, s in ipairs(symbols) do
          local range = s.range or (s.location and s.location.range)
          if range and line >= range.start.line and line <= range['end'].line then
            if s.children then
              local child = find_symbol(s.children)
              if child then
                return child
              end
            end
            return s
          end
        end
      end

      for _, resp in pairs(responses) do
        local sym = find_symbol(resp.result or {})
        if sym and sym.range then
          vim.api.nvim_win_set_cursor(0, { sym.range.start.line + 1, 0 })
          return
        end
      end
    end
    vim.keymap.set('n', '[f', jump_to_current_function_start, { desc = 'Jump to start of current function' })
    local function jump_to_current_function_end()
      local params = { textDocument = vim.lsp.util.make_text_document_params() }
      local responses = vim.lsp.buf_request_sync(0, 'textDocument/documentSymbol', params, 1000)
      if not responses then
        return
      end

      local pos = vim.api.nvim_win_get_cursor(0)
      local line = pos[1] - 1

      local function find_symbol(symbols)
        for _, s in ipairs(symbols) do
          local range = s.range or (s.location and s.location.range)
          if range and line >= range.start.line and line <= range['end'].line then
            if s.children then
              local child = find_symbol(s.children)
              if child then
                return child
              end
            end
            return s
          end
        end
      end

      for _, resp in pairs(responses) do
        local sym = find_symbol(resp.result or {})
        if sym and sym.range then
          -- jump to end of the symbol
          vim.api.nvim_win_set_cursor(0, { sym.range['end'].line + 1, 0 })
          return
        end
      end
    end
    vim.keymap.set('n', ']f', jump_to_current_function_end, { desc = 'Jump to end of current function' })
  end,
})
vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.keymap.set('n', '<leader>u', function()
  vim.cmd.packadd 'nvim.undotree'
  vim.cmd 'Undotree'
end, { desc = 'Toggle Undotree' })

vim.filetype.add {
  extension = {
    h = 'c',
    hpp = 'cpp',
  },
}

-- Load snippets
-- Sky.load_snippets = function(snippets)
--   if type(snippets) ~= 'table' then
--     return
--   end
--
--   -- local count = 0
--   for trigger, body in pairs(snippets) do
--     count = count + 1
--     vim.keymap.set('ia', trigger, function()
--       vim.snippet.expand(body)
--     end)
--   end
--
--   -- vim.notify(string.format(' 󰄬  Loaded %d snippets', count), vim.log.levels.INFO)
-- end

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'cpp',
--   callback = function()
--     Sky.load_snippets(Sky.snippets.cpp)
--   end,
-- })
