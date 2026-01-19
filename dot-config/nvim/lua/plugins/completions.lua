return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"onsails/lspkind.nvim",
		},

		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- local ts_utils = require("nvim-treesitter.ts_utils")
			local ts_utils = require("nvim-treesitter.util")

			require("luasnip.loaders.from_vscode").lazy_load()

			local ts_node_func_parens_disabled = {
				-- ecma
				named_imports = true,
				-- rust
				use_declaration = true,
			}

			local default_handler = cmp_autopairs.filetypes["*"]["("].handler
			cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
				local node_type = ts_utils.get_node_at_cursor():type()
				if ts_node_func_parens_disabled[node_type] then
					if item.data then
						item.data.funcParensDisabled = true
					else
						char = ""
					end
				end
				default_handler(char, item, bufnr, rules, commit_character)
			end

			cmp.event:on(
				"confirm_done",
				cmp_autopairs.on_confirm_done({
					sh = false,
				})
			)

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = {
							menu = 50,
							abbr = 50,
						},
						ellipsis_char = "...",
						show_labelDetails = true,
						menu = {
							buffer = "[Buf]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
						},
					}),
				},

				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<C-Space>"] = cmp.mapping.complete(), -- Conflict with macOS hotkey
					["<C-r>"] = cmp.mapping.complete(),
					["<C-q>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "vsnip" }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		dependencies = {
			"lukas-reineke/indent-blankline.nvim",
		},

		config = function()
			local rainbow = require("rainbow-delimiters")
			local ibl = require("ibl")

			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow = {
				strategy = {
					[""] = rainbow.strategy["global"],
					vim = rainbow.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = highlight,
			}
			ibl.setup({
				scope = {
					enabled = true,
					highlight = highlight,
				},
				indent = {
					char = "▏",
					smart_indent_cap = true,
				},
			})
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
}
