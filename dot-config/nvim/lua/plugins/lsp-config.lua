return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.bashls.setup({})

			--vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			--vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		vim.diagnostic.config({
			virtual_text = false,
--			virtual_text = {
--				source = 'if_many',
--			},
--			severity_sort = 'true',
			float = {
      	focusable = false,
      	close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      	border = 'rounded',
      	source = 'if_many',
      	prefix = '■ ',
      	scope = 'cursor',
			},
--			signs = {
--				text = {
--					[vim.diagnostic.severity.ERROR] = "󰅚 ",
--      		[vim.diagnostic.severity.WARN] = "󰀪 ",
--      		[vim.diagnostic.severity.INFO] = " ",
--      		[vim.diagnostic.severity.HINT] = "󰌶 ",
--				}
--			}
		})
	},
}
