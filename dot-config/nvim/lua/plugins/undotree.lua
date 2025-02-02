return {
	"mbbill/undotree",
	lazy = true,
	cmd = "UndotreeToggle",
	keys = {
		{
			"<leader>ud",
			function()
				-- Ensure consistent width before toggling
				local width = 24
				vim.g.undotree_SplitWidth = width

				-- Toggle Undotree
				vim.cmd("UndotreeToggle")

				-- Defer to allow Undotree to initialize
				vim.defer_fn(function()
					-- Find Undotree window and resize
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "undotree" then
							vim.api.nvim_win_set_width(win, width)
							break
						end
					end
				end, 50)
			end,
			desc = "Toggle UndoTree",
		},
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_DiffpanelHeight = 17
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_DiffCommand = "diff"

		-- Ensure Undotree window is always the right size
		vim.api.nvim_create_augroup("UndotreeCustom", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			group = "UndotreeCustom",
			pattern = "undotree*",
			callback = function()
				vim.defer_fn(function()
					local width = 24
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "undotree" then
							vim.api.nvim_win_set_width(win, width)

							-- Attempt to focus and enable interaction
							vim.api.nvim_set_current_win(win)
							-- vim.cmd("normal! G") -- Move cursor to bottom
							break
						end
					end
				end, 50)
			end,
		})

		-- Custom autocmd to handle cursor and interaction
		vim.api.nvim_create_autocmd("BufEnter", {
			group = "UndotreeCustom",
			pattern = "undotree*",
			callback = function()
				-- Ensure cursor can interact
				vim.wo.cursorline = true
				vim.cmd("setlocal cursorline")
				-- vim.cmd("normal! G") -- Move cursor to bottom
			end,
		})
	end,
}
