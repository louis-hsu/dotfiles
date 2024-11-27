return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			-- 	highlights = {
			-- 		separator = {
			-- 			fg = "black",
			-- 			bg = "none",
			-- 		},
			-- 		separator_selected = {
			-- 			fg = "black",
			-- 			bg = "#282a36",
			-- 		},
			-- 		buffer_selected = {
			-- 			bg = "#282a36",
			-- 		},
			-- 		buffer_visible = {
			-- 			bg = "none",
			-- 		},
			-- 	},
			options = {
				mode = "buffers",
				separator_style = { "|", "|" },
				style_preset = bufferline.style_preset.no_italic,
				indicator = {
					style = "underline",
				},
				diagnostics = "nvim-lsp",
				color_icons = true,
				-- hover = {
				-- 	enabled = true,
				-- 	delay = 150,
				-- 	reveal = { "close" },
				-- },
			},
		})
	end,
}
