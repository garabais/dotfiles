local nvim_lsp = require('lspconfig')

require('config.lsp.diagnostics')
require('config.lsp.kind').setup()

local on_attach = function(client, bufnr)
  require('config.lsp.general').setup(client, bufnr)
  require('config.lsp.keys').setup(client, bufnr)
  require('config.lsp.formatting').setup(client, bufnr)
  require('config.lsp.highlight').setup(client, bufnr)
end

local handlers = require('config.lsp.handlers')

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function setup_servers()
  require'lspinstall'.setup()

  local servers = require'lspinstall'.installed_servers()

  for _, server in pairs(servers) do
    nvim_lsp[server].setup{
      on_attach = on_attach,
      handlers = handlers,
      capabilities = capabilities,
    }
  end

end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  -- reload installed servers
  setup_servers() 

  -- close the download split
  vim.cmd('on') 

  -- this triggers the FileType autocmd that starts the server
  vim.cmd('bufdo e') 
end

