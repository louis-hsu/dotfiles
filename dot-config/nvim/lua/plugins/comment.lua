return {
	"numToStr/Comment.nvim",
	config = function()
		local comment = require("Comment")

		comment.setup({
			extra = { above = "gca", below = "gcb", eol = "gce" },
		})

		-- https://github.com/numToStr/Comment.nvim/issues/483
		-- Temporary solution to disable nvim native commenting keymapping
		-- I also don't need to much fancy commenting skills
		-- Louis 2025/0613
		vim.keymap.del("n", "gc")
		vim.keymap.del("n", "gb")
		local wk = require("which-key")
		wk.add({
			{ "gb", group = "Comment toggle blockwise" },
			{ "gc", group = "Comment toggle linewise" },
		})
	end,
}
