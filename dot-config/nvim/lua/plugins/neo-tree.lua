return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						".git",
					},
					never_show = {
						".DS_Store",
						"undo",
						"thumbs.db",
					},
					never_show_by_pattern = {
						"Icon?",
					},
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "✱", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "✔︎",
						conflict = "",
					},
				},
			},
		})
	end,
	keys = {
		{
			"<C-n>",
			"<Cmd>Neotree toggle filesystem reveal left<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Toggle Neo-tree",
		},
	},
}
