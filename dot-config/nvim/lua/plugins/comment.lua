return {
	"numToStr/Comment.nvim",
	config = function()
		local comment = require("Comment")

		comment.setup({
			extra = { above = "gca", below = "gcb", eol = "gce" },
		})
	end,
}
