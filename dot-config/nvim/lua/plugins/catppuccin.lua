return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavor = "mocha",
			transparent_background = true,

---@diagnostic disable-next-line: unused-local
      custom_highlights = function(colors)
        return {
          Comment = { fg = "#5c6370" },
        }
      end
    })
		vim.cmd.colorscheme("catppuccin")
	end,
}