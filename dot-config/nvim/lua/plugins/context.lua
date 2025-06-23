return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		local context = require("treesitter-context")

		context.setup({
			multiwindow = true,
			-- extra = { above = "gca", below = "gcb", eol = "gce" },
		})
	end,
}
