return {
	"christoomey/vim-tmux-navigator",
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		config = function()
			-- Remove old mappings
			vim.keymap.del("n", "<C-h>")
			vim.keymap.del("n", "<C-j>")
			vim.keymap.del("n", "<C-k>")
			vim.keymap.del("n", "<C-l>")
			vim.keymap.del("n", "<C-\\>")
			-- Set with descriptions
			vim.keymap.set(
				"n",
				"<C-h>",
				"<cmd>TmuxNavigateLeft<CR>",
				{ desc = "Navigate to left window", silent = true }
			)
			vim.keymap.set(
				"n",
				"<C-j>",
				"<cmd>TmuxNavigateDown<CR>",
				{ desc = "Navigate to window below", silent = true }
			)
			vim.keymap.set(
				"n",
				"<C-k>",
				"<cmd>TmuxNavigateUp<CR>",
				{ desc = "Navigate to window above", silent = true }
			)
			vim.keymap.set(
				"n",
				"<C-l>",
				"<cmd>TmuxNavigateRight<CR>",
				{ desc = "Navigate to right window", silent = true }
			)
			vim.keymap.set(
				"n",
				"<C-\\>",
				"<cmd>TmuxNavigatePrevious<CR>",
				{ desc = "Navigate to previous window", silent = true }
			)
		end,
	},
}
