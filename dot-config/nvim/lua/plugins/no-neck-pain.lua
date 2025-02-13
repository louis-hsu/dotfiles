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
			},
		})
	end,

	vim.keymap.set("n", "<leader>np", "<Cmd>NoNeckPain<CR>"),
	-- vim.keymap.set("n", "<C-h>", function()
	-- 	-- Try to move left
	-- 	vim.cmd("wincmd h")
	-- 	local win_info = vim.api.nvim_win_get_config(0)
	--
	-- 	-- If in a no-neck-pain side buffer, move to tmux instead
	-- 	if win_info.relative ~= "" then
	-- 		vim.cmd("!tmux select-pane -L")
	-- 	end
	-- end, { noremap = true, silent = true }),
	--
	-- vim.keymap.set("n", "<C-l>", function()
	-- 	-- Try to move right
	-- 	vim.cmd("wincmd l")
	-- 	local win_info = vim.api.nvim_win_get_config(0)
	--
	-- 	-- If in a no-neck-pain side buffer, move to tmux instead
	-- 	if win_info.relative ~= "" then
	-- 		vim.cmd("!tmux select-pane -R")
	-- 	end
	-- end, { noremap = true, silent = true }),
}
