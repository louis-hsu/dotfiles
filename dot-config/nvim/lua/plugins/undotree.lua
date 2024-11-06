return {
	"mbbill/undotree",
	lazy = true, -- Load only when the keybinding or command is triggered
	cmd = "UndotreeToggle", -- Load the plugin when this command is used
	keys = {
		{ "<leader>ud", "<Cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_DiffpanelHeight = 15
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_DiffCommand = "diff"
	end,
}
