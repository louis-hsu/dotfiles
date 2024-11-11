return {
	"shortcuts/no-neck-pain.nvim",

	config = function()
		-- Create scratchPad directory
		local scratchpad_dir = vim.fn.stdpath("data") .. "/scratchPad"
		if vim.fn.isdirectory(scratchpad_dir) == 0 then
			vim.fn.mkdir(scratchpad_dir, "p")
		end

		local nopain = require("no-neck-pain")
		nopain.setup({
			width = 120,
			buffers = {
				right = {
					enabled = true,
					scratchPad = {
						enabled = true,
						pathToFile = vim.fn.stdpath("data") .. "/scratchPad/scratchPad.md",
					},
				},
				left = {
					enabled = true,
				},
			},
		})
	end,

	vim.keymap.set("n", "<leader>np", "<Cmd>NoNeckPain<CR>"),
	-- vim.keymap.set("n", "<leader>ns", "<Cmd>NoNeckPainScratchPad<CR>"),
}
