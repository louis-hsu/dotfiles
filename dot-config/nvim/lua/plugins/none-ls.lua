return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.google_java_format,
				-- null_ls.builtins.formatting.pyink,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.diagnostics.pylint,
				--        null_ls.builtins.diagnostics.eslint_d,
				--        null_ls.builtins.diagnostics.rubocop, -- For Ruby
				--        null_ls.builtins.formatting.rubocop,
			},
			on_attach = function(client, bufnr)
				-- Auto formating before saving
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		--vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
