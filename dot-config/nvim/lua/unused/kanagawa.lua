return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	name = "kanagawa",
	priority = 1000,
	config = function()
		local config = require("kanagawa")
		config.setup({
			transparent = true,
			theme = "dragon",
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
