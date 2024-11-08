return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		-- Function to get Python path from virtualenv
		local function get_python_path()
			local venv = vim.fn.environ()["VIRTUAL_ENV"]
			if venv then
				return venv .. "/bin/python"
			end
			return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
		end

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.google_java_format,
				-- null_ls.builtins.formatting.pyink,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.mypy.with({ -- Setup to enable 'mypy' in virtual env
					extra_args = {
						"--python-executable",
						get_python_path(),
						"--namespace-packages",
						"--no-site-packages",
						"--ignore-missing-imports",
					},
					cwd = function(params)
						return vim.fn.getcwd()
					end,
				}),
				-- null_ls.builtins.diagnostics.pylint,
				--        null_ls.builtins.diagnostics.eslint_d,
				--        null_ls.builtins.diagnostics.rubocop, -- For Ruby
				--        null_ls.builtins.formatting.rubocop,
			},
			-- on_attach = function(client, bufnr)
			-- 	-- Auto formating before saving
			-- 	if client.supports_method("textDocument/formatting") then
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			buffer = bufnr,
			-- 			callback = function()
			-- 				vim.lsp.buf.format({ bufnr = bufnr })
			-- 			end,
			-- 		})
			-- 	end
			-- end,
		})

		--vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
