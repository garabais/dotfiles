local handlers = {
			['textDocument/publishDiagnostics'] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics, {
					-- Enable virtual_text
					-- virtual_text = {spacing = 1},
					virtual_text = false,
					signs = true,
					update_in_insert = true,
					severity_sort = true,
				}
			),
}


return handlers
