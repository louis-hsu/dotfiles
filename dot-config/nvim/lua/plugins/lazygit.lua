-- nvim v0.8.0
return {
	"kdheepak/lazygit.nvim",
	--lazy = false,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("lazygit")
	end,
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{
			"<leader>lg",
			"<Cmd>LazyGit<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "LazyGit",
		},
	},
}
