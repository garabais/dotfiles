local M = {}

function M.setup(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<Leader>F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    buf_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    -- buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

return M
