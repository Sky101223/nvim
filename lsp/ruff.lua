return {
  cmd = { 'ruff', 'server' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  filetypes = { 'python' },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end,
}
