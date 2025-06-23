return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		local noice = require("noice")
		local notify = require("notify")

		noice.setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				bottom_search = false,    -- use a classic bottom cmdline for search
				-- command_palette = true,   -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false,       -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true,    -- add a border to hover docs and signature help
			},
			views = {
				cmdline_popup = {
					position = {
						row = "30%",
						col = "50%",
					},
				},
			},
		})

		notify.setup({
			timeout = 3000,
			-- stages = "static",
			background_colour = "#000000",
		})
	end,
}
