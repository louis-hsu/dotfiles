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
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.jdtls.setup({ capabilities = capabilities })
			lspconfig.pyre.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })

			--vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			--vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
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
