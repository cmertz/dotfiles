function org_imports()
	local clients = vim.lsp.buf_get_clients()
	for _, client in pairs(clients) do

		local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
		params.context = {only = {"source.organizeImports"}}

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = function()
	if vim.lsp.buf.format ~= nil then
		vim.lsp.buf.format()
	end
end, })

vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = function()
	org_imports()
end, })
