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


local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
      on_attach = on_attach,
      handlers = handlers,
      capabilities = capabilities,
  }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

