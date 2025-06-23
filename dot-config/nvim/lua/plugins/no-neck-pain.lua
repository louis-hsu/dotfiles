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
			minSideBufferWidth = 10,

			autocmds = {
				-- 1. Turning it on would block cursor movement when it is in one of
				-- tmux panes
				-- 2. Turning it off would interupt curor movement when it is in one of
				-- tmux panes, and break the flow from editor to message/notification
				-- window
				-- Trun it on for now with less inconvenience -- Louis 2025/0623
				--
				-- TODO:
				-- Check NNP source code to see if it's possible to have different
				-- behavior while in tmux environment
				skipEnteringNoNeckPainBuffer = true,
			},
			-- Decide to remove buffer/scratchpad function since
			-- 'skipEnteringNoNeckPainBuffer' doesn't work on one side only, and this
			-- feature is more important than scrachpad -- Louis 2024/1217
			buffers = {
				right = {
					enabled = true,
					-- scratchPad = {
					-- 	enabled = true,
					-- 	pathToFile = vim.fn.stdpath("data") .. "/scratchPad/scratchPad.md",
					-- },
				},
				left = {
					enabled = true,
				},
			},

			integrations = {
				undotree = {
					width = 24,
					position = "right",
				},

				NeoTree = {
					-- position = "left",
					reopen = true,
				},
			},
		})
	end,

	-- Change global variable 'vim.g.no_neck_pain_active' to track no-neck-pain
	-- toggle status
	vim.keymap.set("n", "<leader>np", function()
		vim.g.no_neck_pain_active = not vim.g.no_neck_pain_active
		vim.cmd("NoNeckPain")
	end, { desc = "Toggle NoNickPain", noremap = true, silent = true }),
}
