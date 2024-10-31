return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local on_attach = function(client, bufnr)
				local bufopts = { noremap=true, silent=true, buffer=bufnr }
				--vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
				--vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { noremap = true, silent = true })
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, bufopts)
				vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

				-- Auto-formation before saving
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function() vim.lsp.buf.format() end,
					})
				end
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = {"lua"},
			})
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.jdtls.setup({ capabilities = capabilities })
			lspconfig.ruff.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = {"python"},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = {"python"},
			})

		end,
	},
	{
		vim.diagnostic.config({
			virtual_text = false,
			-- virtual_text = {
			--		source = 'if_many',
			-- },
			-- severity_sort = 'true',
			float = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "if_many",
				prefix = "■ ",
				scope = "cursor",
			},
			-- signs = {
			--		text = {
			--			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			--			[vim.diagnostic.severity.WARN] = "󰀪 ",
			--			[vim.diagnostic.severity.INFO] = " ",
			--			[vim.diagnostic.severity.HINT] = "󰌶 ",
			--		}
			-- }
		}),
	},
}
