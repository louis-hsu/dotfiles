-- Add yazi file manager to neovim via yazi.lua
-- https://github.com/mikavilpas/yazi.nvim
-- Louis 2025/0213
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		-- 👇 in this section, choose your own keymappings!
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open Yazi at the current file",
		},
		{
			-- Open in the current working directory
			"<leader>yw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open Yazi in initial working directory",
		},
		{
			"<leader>yr",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last Yazi session",
		},
	},

	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = false,
		keymaps = {
			show_help = "<f1>",
		},
	},
}
