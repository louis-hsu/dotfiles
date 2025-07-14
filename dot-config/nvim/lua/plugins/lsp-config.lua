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
		-- opts = {
		-- 	automatic_installation = true,
		-- },
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local on_attach = function(client, bufnr)
				--vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { noremap = true, silent = true })
				vim.keymap.set(
					"n",
					"<leader>ck",
					vim.lsp.buf.hover,
					{ desc = "Hover info about the symbol under cursor", noremap = true, silent = true, buffer = bufnr }
				)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {
					desc = "Show code reference of the symbol under cursor",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {
					desc = "Show code definition of the symbol under cursor",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
					desc = "Show code action of the symbol under cursor",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {
					desc = "Linter the code format",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, {
					desc = "Show code implementation of the symbol under cursor",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
					desc = "Rename the symbol under cursor",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})

				-- Auto-formation before saving
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end

			local function findTheClosestMatch(patterns)
				return function(fname)
					local path = vim.fs.dirname(fname)
					local match = nil

					while path do
						-- print("Current path: ", path)
						for _, pattern in ipairs(patterns) do
							if vim.fn.glob(path .. "/" .. pattern) ~= "" then
								match = path
								-- print("Match: ", match)
								return match
							end
						end
						local parent = vim.fs.dirname(path)
						if parent == path then
							break
						end
						path = parent
					end
					-- print("Match: ", match)
					return match
				end
			end

			local root_pattern = require("utilis.root_pattern")
			require("lspconfig").lua_ls.setup({
				root_dir = function(fname)
					local root = root_pattern.closest_root_pattern({ ".luarc.json", "init.lua", ".git" })(fname)
					-- local root = findTheClosestMatch({ ".luarc.json", "init.lua", ".git" })(fname)
					-- print("DEBUG: root_dir is", root)
					return root or vim.fn.fnamemodify(fname, ":p:h")
				end,
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
							maxPreload = 5000,
							preloadFileSize = 50000,
							library = {
								vim.fn.stdpath("config"),
							},
						},
						diagnostics = {
							enable = true,
							globals = { "vim" },
						},
						telemetry = { enable = false },
					},
				},
				cmd_env = {
					LUA_LS_LOGLEVEL = "trace",
				},

				-- Add these if you need them:
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "typescript", "javascript" },
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "sh" },
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "java" },
			})
			lspconfig.ruff.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "python" },
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "python" },
			})
			lspconfig.kotlin_language_server.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "kotlin" },
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
