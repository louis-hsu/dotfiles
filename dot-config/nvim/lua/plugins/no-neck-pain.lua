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
				-- Turn to ture or it would block curor moving between tmux pane when
				-- there is a buffer in between -- Louis 2025/0130
				skipEnteringNoNeckPainBuffer = false,
			},
			-- Decide to remove buffer/scratchpad function since
			-- 'skipEnteringNoNeckPainBuffer' doesn't work on one side only, and this
			-- feature is more important than scrachpad -- Louis 2024/1217
			--
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

	-- vim.keymap.set("n", "<leader>np", "<Cmd>NoNeckPain<CR>"),
	-- Change global variable 'vim.g.no_neck_pain_active' to track no-neck-pain
	-- toggle status
	vim.keymap.set("n", "<leader>np", function()
		vim.g.no_neck_pain_active = not vim.g.no_neck_pain_active
		vim.cmd("NoNeckPain")
	end, { noremap = true, silent = true }),
}
