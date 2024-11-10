return {
	"navarasu/onedark.nvim",
	lazy = false,
	name = "onedark",
	priority = 1000,
	config = function()
		local config = require("onedark")
		config.setup({
			style = "warmer",
			transparent = true,
		})
		vim.cmd.colorscheme("onedark")
	end,
}
