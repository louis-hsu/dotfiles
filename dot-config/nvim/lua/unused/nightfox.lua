return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	name = "nightfox",
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = true,
			},
			styles = {
				-- comments = { fg = "#5c6370", italic },
				comments = "italic",
			},
		})
		vim.cmd.colorscheme("nordfox")
		-- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f28fad', bold = true })
	end,
}
