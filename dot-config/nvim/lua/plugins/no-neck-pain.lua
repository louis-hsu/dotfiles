return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",

	config = function()
		-- Create scratchPad directory
		local scratchpad_dir = vim.fn.stdpath("data") .. "/scratchPad"
		if vim.fn.isdirectory(scratchpad_dir) == 0 then
			vim.fn.mkdir(scratchpad_dir, "p")
		end

		local nopain = require("no-neck-pain")
		nopain.setup({
			width = 120,
			minSideBufferWidth = 20,

			autocmds = {
				skipEnteringNoNeckPainBuffer = true,
			},
			-- Decide to remove buffer/scratchpad function since
			-- 'skipEnteringNoNeckPainBuffer' doesn't work on one side only, and this
			-- feature is more important than scrachpad -- Louis 2024/1217
			--
			-- buffers = {
			-- 	right = {
			-- 		-- enabled = true,
			-- 		scratchPad = {
			-- 			enabled = true,
			-- 			pathToFile = vim.fn.stdpath("data") .. "/scratchPad/scratchPad.md",
			-- 		},
			-- 	},
			-- 	left = {
			-- 		enabled = false,
			-- 	},
			-- },

			integrations = {
				undotree = {
					width = 24,
					position = "right",
				},
			},
		})
	end,

	vim.keymap.set("n", "<leader>np", "<Cmd>NoNeckPain<CR>"),
}
