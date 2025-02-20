return {
	{
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify", -- optional
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			local l_dracula = require("lualine.themes.dracula")
			l_dracula.normal.a.bg = "#8ac6f2"
			l_dracula.insert.a.bg = "#95e454"
			l_dracula.replace.a.bg = "#e5786d"

			require("lualine").setup({
				options = {
					theme = l_dracula,
					-- ignore_focus = { "neo-tree", "undotree", "no-neck-pain" },
					disabled_filetypes = {
						-- statusline = { "neo-tree", "undotree", "no-neck-pain" },
						winbar = { "neo-tree", "undotree", "no-neck-pain" },
					},
					globalstatus = false,
					-- refresh = { statusline = 100 },
				},
				sections = {
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					-- lualine_x = { "encoding", "fileformat", "filetype", "progress", "location" },
					-- lualine_x = {},
					lualine_y = {
						{
							require("recorder").displaySlots,
						},
					},
					lualine_z = {
						{
							require("recorder").recordingStatus,
						},
					},
				},
				winbar = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"branch",
							icon = "󰘬",
						},
						"diff",
						"diagnostics",
					},
					lualine_c = { "filename" },
					-- lualine_x = { "encoding", "fileformat", "filetype", "progress", "location" },
					lualine_x = { "progress", "location" },
				},
				inactive_winbar = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_x = { "location" },
				},
			})
		end,
	},
}
